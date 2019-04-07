# Azure DevOps Extensions for Microsoft SQL Server Deployment Tasks

This extension offers a number of extensions for build and deployment tasks related to Microsoft SQL Server.  Two tasks are currently provided, more coming in the future.

## Tasks
This extension adds the following tasks:
* Publish DACPAC using a DAC Publish Profile

Details of how to configure each task is given below.

# Publish DACPAC using a DAC Publish Profile

The **Publish DACPAC** task allows you to deploy a SQL Server Database DACPAC to a SQL Server instance using a DAC Publish Profile.

SSDT (SQL Server Data Tools) is Microsoft's design tool to declare the entire database model including tables, views, stored procedures, functions, schemas, etc. etc. etc.  covering **all** aspects of a database design.

SSDT is now fully integrated into Visual Studio.  When you perform a **build** of a SSDT Visual Studio project, it creates a [DACPAC](https://msdn.microsoft.com/en-IN/library/ee210546.aspx) which defines all of the SQL Server objects - like tables, views, and instance objects, including logins - associated with a database.

The **Publish DACPAC** task simplifies the use of [SqlPackage.exe](https://docs.microsoft.com/en-us/sql/tools/sqlpackage) to deploy a [DACPAC](https://msdn.microsoft.com/en-IN/library/ee210546.aspx) by using a [DAC Publish Profile](https://github.com/DrJohnT/PublishDacPac/wiki/DAC-Publish-Profile)  which provides for fine-grained control over the database creation and upgrades, including upgrades for schema, triggers, stored procedures, roles, users, extended properties etc. Using a [DAC Publish Profile](https://github.com/DrJohnT/PublishDacPac/wiki/DAC-Publish-Profile), multiple different properties can be set to ensure that the database is created or upgraded properly.

The **Publish DACPAC** task compares the content of a DACPAC to the database already on the target server and generates a deployment script.  You can tailor how publish works using a [DAC Publish Profile](https://github.com/DrJohnT/PublishDacPac/wiki/DAC-Publish-Profile).

The **Publish DACPAC** task can be used to automate the deployment of databases, either as part of a build in an Azure DevOps pipeline, or as part of a server deployment using Azure DevOps Release Manager.

To deploy databases using [Octopus Deploy](https://octopus.com/) you can utilise the PowerShell module [PublishDacPac](https://github.com/DrJohnT/PublishDacPac/) which underpins the Publish DACPACO task.

To automate build and deployment of databases in Azure DevOps, you can use MsBuild to create DACPAC from your Visual Studio solution.  You can then add this task to deploy each DACPAC using your own custom [DAC Publish Profile](https://github.com/DrJohnT/PublishDacPac/wiki/DAC-Publish-Profile).

[DAC Publish Profiles](https://github.com/DrJohnT/PublishDacPac/wiki/DAC-Publish-Profile) are created in Visual Studio when you Publish a database.

![Publish DACPAC Task Configuration](images/AzureDevOpsTaskDetail.png "Publish DACPAC Task Configuration")