# Introduction

Will delete ALL repositories from the Eezze-projects account!!

You will need to install;
- `gh` cli tool to execute the delete commands.
- Then before executing the `delete-all-eezze-projects.sh` script, execute and authorize:
    - `gh auth login` , to login to Github.
    - `gh auth refresh -h github.com -s delete_repo` , to allow the `delete_repo` operation.