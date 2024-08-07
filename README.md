# DevOpsFetch

DevOpsFetch is a tool for server information retrieval and monitoring. It collects and displays system information, including active ports, user logins, Nginx configurations, Docker images, and container statuses. It also includes a systemd service for continuous monitoring and logging.

## Features

- Display all active ports and services.
- Provide detailed information about a specific port.
- List all Docker images and containers.
- Provide detailed information about a specific Docker container.
- Display all Nginx domains and their ports.
- Provide detailed configuration information for a specific Nginx domain.
- List all users and their last login times.
- Provide detailed information about a specific user.
- Display activities within a specified time range.

## Requirements

- Python 3
- Docker
- Nginx

## Installation

### Step 1: Clone the Repository

git clone https://github.com/seyramgabriel/HNG-DevOps-Fetch-Tool

```
cd HNG-DevOps-Fetch-Tool
```

Step 2: Make the Installation Script Executable
```sh
chmod +x install.sh
```

Step 3: Run the Installation Script

The installation script will check for the availability of dependencies and install them if necessary. It will also set up the devopsfetch systemd service. Ensure you modify path to devopsfetch.sh in the devopsfetch.service file to reflect the location of the script before you run install.sh.

```
./install.sh
```

#### Usage

##### Running the Script Manually

You can use devopsfetch.sh to retrieve various system information. 

Here are the available options:

```sh
./devopsfetch.sh [OPTIONS]
```

Options
-p, --port [PORT_NUMBER]

Display all active ports and services, or detailed info about a specific port.

Examples:

```sh
./devopsfetch.sh -p       # List all active ports
./devopsfetch.sh -p 80    # Get detailed information about port 80
```

-d, --docker [CONTAINER]

List all Docker images and containers, or detailed info about a specific container.

Examples:

```sh
./devopsfetch.sh -d                # List all Docker images and containers
./devopsfetch.sh -d my_container   # Get detailed information about a specific container
```

-n, --nginx [DOMAIN]

Display all Nginx domains and their ports, or detailed config info for a specific domain.

Examples:

```sh
./devopsfetch.sh -n               # List all Nginx domains and their ports
./devopsfetch.sh -n example.com   # Get detailed configuration information for a specific domain
```

-u, --users [USERNAME]

List all users and their last login times, or detailed info about a specific user.

Examples:

```sh
./devopsfetch.sh -u            # List all users and their last login times
./devopsfetch.sh -u my_user    # Get detailed information about a specific user
```

-t, --time [TIME_RANGE]

Display activities within a specified time range.

Example:

```sh
./devopsfetch.sh -t 2023-01-01 2023-12-31    # Display activities from 2023-01-01 to 2023-12-31
```

-h, --help

Show the help message and exit.

Example 

```sh
./devopsfetch.sh -h
```

#### Continuous Monitoring with Systemd

The devopsfetch tool includes a systemd service for continuous monitoring and logging.

#### Start the Service

```sh
sudo systemctl start devopsfetch.service
```

```sh
sudo systemctl enable devopsfetch.service
# Enable the Service to Start on Boot
```

```sh
sudo systemctl status devopsfetch.service
# Check the Status of the Service
```

#### View the Logs
The logs are managed by systemd. You can view the logs using journalctl.

```sh
journalctl -u devopsfetch.service
```

### To make the devopsfetch.sh file executable at any and every location without quoting the path to the script

#### Check Current PATH Directories

```echo $PATH```

Example output:

/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

#### Move the devopsfetch.sh script to one of the directories listed in your PATH. For example:

```
sudo mv /path/to/devopsfetch.sh /usr/local/bin/devopsfetch
```

Example

```
sudo mv /home/ubuntu/devopsfetch.sh /usr/local/bin/devopsfetch
```

#### Ensure the script is executable:

```
sudo chmod +x /usr/local/bin/devopsfetch
```

#### Update the devopsfetch.service (located in /etc/systemd/system) file with the new location of devopsfetch script

Example

ExecStart=/usr/local/bin/devopsfetch  

Run ```which devopsfetch``` to output the location of devopsfetch script in order to update the devopsfetch.service file correctly with the path.

#### Now you can run the devopsfetch script at any location without absolute path referencing

```
devopsfetch [ options ]
```

Example

```
devopsfetch -d
devopsfecth -p
devopsfetch -u
```

### Alternatively:

#### Create a directory and move devopsfetch.sh into that directory

```
mkdir devopsfetch-directory && mv devopsfetch.sh devopsfetch-directory
```

#### Add devopsfetch-directory to $PATH

Run
```
sudo nano ~/.bashrc
```

Scroll down and add this line

```
export PATH=$PATH:/path/to/devopsfetch-directory 
```

 Example 

```
export PATH=$PATH:/home/ubuntu/devopsfetch-directory
```

#### Restart the bash shell

```
source ~/.bashrc
```

Remember to update the devopsfetch.service file (located in /etc/systemd/system) with the new location of devopsfetch script

#### Now you can run the devopsfetch script at any location without absolute path referencing

```
devopsfetch [ options ]
```

Example

```
./devopsfetch -d
./devopsfecth -p
./devopsfetch -u
```



