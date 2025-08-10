#!/bin/bash

# Create log directory
echo "Creating log directory..."
sudo mkdir -p /data/logs
sudo chmod 755 /data/logs
sudo chown $USER:$USER /data/logs

echo "Log directory created at /data/logs"
echo "You can now run the application and logs will be written to /data/logs/inventory-management.log"
