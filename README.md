Steps:
1. Open Terminal or Visual Studio Code. Run awslogin.
2. Access the following role: Mgmt-Console-Dev-D3bCenter@232196027141
3. Open an EC2 instance.
4. Run the following command: psql -w -h kf-dataservice-postgres-prd.kids-first.io -U youngnm kfpostgresprd -f kf_refresh_export.sql
5. Download the \'93data\'94 folder to your local machine.
6. Run Jupyter notebook to import KF data to the warehouse.
7. Grant access to users for the refreshed kfpostgres tables.