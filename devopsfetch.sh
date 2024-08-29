#!/bin/bash

# Function to display all active ports and services
get_active_ports() {
    ss -tuln
}

# Function to display detailed information about a specific port
get_port_info() {
    local port_number=$1
    ss -tuln | grep ":${port_number}"
}

# Function to list all Docker images and containers
list_docker_info() {
    echo "Docker Images:"
    docker images
    echo ""
    echo "Docker Containers:"
    docker ps -a
    echo ""
    echo "Docker Containers running"
    docker ps
}

# Function to display detailed information about a specific container
get_container_info() {
    local container_name=$1
    docker inspect "$container_name"
}

# Function to display all Nginx domains and their ports
list_nginx_domains() {
    nginx -T
}

# Function to display detailed configuration information for a specific domain
get_nginx_config() {
    local domain=$1
    nginx -T | grep -A 10 "server_name $domain"
}

# Function to list all users and their last login times
list_users() {
    lastlog
}

# Function to display detailed information about a specific user
get_user_info() {
    local username=$1
    id "$username"
    grep "^$username:" /etc/passwd
    lastlog -u "$username"
}

# Function to display activities within a specified time range
display_activities_within_time_range() {
    local start_time=$1
    local end_time=$2

    echo "Activities from $start_time to $end_time"

    # Convert start and end times to timestamp format
    local start_timestamp=$(date -d "$start_time" +%s)
    local end_timestamp=$(date -d "$end_time" +%s)

    echo "Docker container logs:"
    docker ps -q | xargs -I{} docker logs --since "$start_time" --until "$end_time" {}

    echo "Nginx logs:"
    grep -E "^\[(.*)\]" /var/log/nginx/access.log | awk -v start="$start_timestamp" -v end="$end_timestamp" '
    {
        split($4, a, "[/:]");
        log_timestamp = mktime(a[2] " " a[3] " " a[4] " " a[5] " " a[6] " " a[7]);
        if (log_timestamp >= start && log_timestamp <= end) {
            print $0;
        }
    }'

    echo "System logs:"
    journalctl --since="$start_time" --until="$end_time"
}

# Function to display help
display_help() {
    cat << EOF
Usage: $0 [OPTIONS]

Options:
  -p, --port [PORT_NUMBER]    Display all active ports and services, or detailed info about a specific port.
  -d, --docker [CONTAINER]    List all Docker images and containers, or detailed info about a specific container.
  -n, --nginx [DOMAIN]        Display all Nginx domains and their ports, or detailed config info for a specific domain.
  -u, --users [USERNAME]      List all users and their last login times, or detailed info about a specific user.
  -t, --time [TIME_RANGE]     Display activities within a specified time range.
  -h, --help                  Show this message and exit.

Examples:
  - List all active ports:
    $0 -p

  - Get detailed information about port 80:
    $0 -p 80

  - List all Docker images and containers:
    $0 -d

  - Get detailed information about a specific container:
    $0 -d my_container

  - List all Nginx domains and their ports:
    $0 -n

  - Get detailed configuration information for a specific domain:
    $0 -n example.com

  - List all users and their last login times:
    $0 -u

  - Get detailed information about a specific user:
    $0 -u my_user

  - Display activities within a specified time range:
    $0 -t 2023-01-01 2023-12-31
EOF
}

# Main script execution
main() {
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -p|--port)
                if [[ -n $2 && $2 != -* ]]; then
                    get_port_info "$2"
                    shift 2
                else
                    get_active_ports
                    shift
                fi
                ;;
            -d|--docker)
                if [[ -n $2 && $2 != -* ]]; then
                    get_container_info "$2"
                    shift 2
                else
                    list_docker_info
                    shift
                fi
                ;;
            -n|--nginx)
                if [[ -n $2 && $2 != -* ]]; then
                    get_nginx_config "$2"
                    shift 2
                else
                    list_nginx_domains
                    shift
                fi
                ;;
            -u|--users)
                if [[ -n $2 && $2 != -* ]]; then
                    get_user_info "$2"
                    shift 2
                else
                    list_users
                    shift
                fi
                ;;
            -t|--time)
                if [[ -n $2 && -n $3 && $2 != -* && $3 != -* ]]; then
                    # Placeholder for time range functionality
                    display_activities_within_time_range "$2" "$3"
                    shift 3
                else
                    echo "Invalid time range. Please provide start and end dates in the format YYYY-MM-DD."
                    exit 1
                fi
                ;;
            -h|--help)
                display_help
                exit 0
                ;;
            *)
                echo "Invalid option: $1"
                display_help
                exit 1
                ;;
        esac
    done

    if [[ "$#" -eq 0 ]]; then
        echo ""
        echo For Usage Instructions run devopsfetch -h    # display_help
    fi
}

main "$@"
