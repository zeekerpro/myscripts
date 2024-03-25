##!/bin/bash

################################################################################
# Script Name: pgsql
# Description:
#   This script provides a convenient way to manage multiple PostgreSQL versions
#   installed on macOS via the asdf version manager. It allows users to list all
#   installed PostgreSQL versions, start or stop specific versions, and restart
#   them as needed. It ensures that at any given time, only one PostgreSQL version
#   is actively running, aiding in development environments where multiple
#   PostgreSQL versions are frequently switched between.
#
#   The script operates by interfacing with PostgreSQL installations located in
#   the specified directory managed by asdf. It uses `pg_ctl` for controlling
#   the PostgreSQL servers, offering a user-friendly command-line interface.
#
# Installation:
#   1. Ensure that Bash, PostgreSQL, and the asdf version manager are installed on your system.
#   2. Save this script as 'pgsql' in a directory included in your system's PATH.
#   3. Make the script executable with the command: chmod +x pgsql
#
# Usage:
#   pgsql list                 - Lists all installed PostgreSQL versions along with their status (running/stopped).
#   pgsql start <version>      - Starts a specific PostgreSQL version, stopping others if necessary.
#   pgsql stop <version>       - Stops the specified PostgreSQL version.
#   pgsql restart <version>    - Restarts the specified PostgreSQL version, stopping others as required.
#   pgsql help                 - Displays usage information and available commands.
#
# Note:
#   This script is intended for use on macOS systems with PostgreSQL installed via asdf.
#   Users should verify that `pg_ctl` is accessible in their PATH. Modify the script
#   accordingly if your PostgreSQL installations or `pg_ctl` are located differently.
#
# Author: Zeeker
# Date: 2024-03-25
################################################################################


# PostgreSQL installations path
PG_PATH="/Users/zeeker/.asdf/installs/postgres/"

# Function to list all installed PostgreSQL versions and their status
list_versions() {
    echo "Installed PostgreSQL Versions:"
    for dir in $PG_PATH*; do
        if [ -d "$dir" ]; then
            version=$(basename "$dir")
            # Check if PostgreSQL version is running
            if pg_ctl -D "$dir" status >/dev/null 2>&1; then
                status="running"
            else
                status="stopped"
            fi
            echo "- $version ($status)"
        fi
    done
}

# Function to start a specific PostgreSQL version
start_version() {
    requested_version=$1
    # Stop all running versions first
    for dir in $PG_PATH*; do
        if [ -d "$dir" ] && pg_ctl -D "$dir" status >/dev/null 2>&1; then
            pg_ctl -D "$dir" stop
        fi
    done
    # Start the requested version
    if [ -d "$PG_PATH$requested_version" ]; then
        pg_ctl -D "$PG_PATH$requested_version" start
        echo "PostgreSQL version $requested_version started."
    else
        echo "Version $requested_version not found."
    fi
}

# Function to stop a specific PostgreSQL version
stop_version() {
    requested_version=$1
    if [ -d "$PG_PATH$requested_version" ]; then
        pg_ctl -D "$PG_PATH$requested_version" stop
        echo "PostgreSQL version $requested_version stopped."
    else
        echo "Version $requested_version not found."
    fi
}

# Function to restart a specific PostgreSQL version
restart_version() {
    requested_version=$1
    stop_version $requested_version
    start_version $requested_version
}

# Display help information
show_help() {
    echo "Usage: pgsql [command] [version]"
    echo "Commands:"
    echo "  list                    List all installed PostgreSQL versions."
    echo "  start <version>         Start a specific PostgreSQL version."
    echo "  stop <version>          Stop a specific PostgreSQL version."
    echo "  restart <version>       Restart a specific PostgreSQL version."
    echo "  help                    Show this help information."
}

# Parse command line arguments
case $1 in
    list)
        list_versions
        ;;
    start)
        start_version $2
        ;;
    stop)
        stop_version $2
        ;;
    restart)
        restart_version $2
        ;;
    help)
        show_help
        ;;
    *)
        echo "Invalid command. Use 'pgsql help' for usage information."
        ;;
esac

