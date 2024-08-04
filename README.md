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

git clone <repository-url>

```
cd devopsfetch
```

Step 2: Make the Installation Script Executable
```sh
chmod +x install.sh
```

Step 3: Run the Installation Script

The installation script will check for the availability of dependencies and install them if necessary. It will also set up the devopsfetch systemd service.

```
./install.sh
```

#### Usage

Running the Script Manually
You can use devopsfetch.sh to retrieve various system information. Here are the available options:

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
Enable the Service to Start on Boot
```

```sh
sudo systemctl enable devopsfetch.service
Check the Status of the Service
```

```sh
sudo systemctl status devopsfetch.service
```

#### View the Logs
The logs are managed by systemd. You can view the logs using journalctl.

```sh
journalctl -u devopsfetch.service
```

### Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

### License

This project is licensed under the MIT License.

