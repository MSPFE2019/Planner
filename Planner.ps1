# This script creates a new personal Planner plan using the Microsoft Graph Planner module.
# It prompts the user for the User ID and the Plan Title, then creates the plan in the specified user's container.
# It displays the ID and the details of the created plan.

# Install the Microsoft Graph Planner module. This command installs the module for the current user.
Install-Module -Name Microsoft.Graph.Beta.Planner -Scope CurrentUser -Force

# Import the installed module into the current PowerShell session.
Import-Module -Name Microsoft.Graph.Beta.Planner

# Connect to Microsoft Graph. This command might prompt you for login credentials.
Connect-MgGraph -NoWelcome 

# Prompt the user for the User ID.
$userId = Read-Host -Prompt "Enter the User ID for the plan"

# Prompt the user for the Plan Title.
$planTitle = Read-Host -Prompt "Enter the title for the new plan"

# Create a hash table for the plan parameters.
$params = @{
   
    container = @{
        containerId = $userId
        type = "user"
    }
    title = $planTitle
}
Write-Host $params 
# Create a new personal Planner plan with the specified parameters.
Try {
    $plan = New-MgBetaPlannerPlan -BodyParameter $params
    # Display the ID of the created plan.
    Write-Host "Personal Plan created with ID: $($plan.Id)"
} Catch {
    # Display the error message.
    Write-Error $_.Exception.Message
    # Exit the script with a non-zero exit code.
    Exit 1
}

# Retrieve the details of the newly created personal plan.
Try {
    $planDetails = Get-MgPlannerPlan -PlanId $plan.Id
    # Display the plan details in a list format.
    Write-Host "Personal Plan details: $($planDetails | Format-List)"
} Catch {
    # Display the error message.
    Write-Error $_.Exception.Message
    # Exit the script with a non-zero exit code.
    Exit 1
}

