# Download latest container image
/system/script run download-container

# Wait for the download to complete by checking the file existence or download status
:while ([/file find name=usb1-part1/router-satellite-alpine-linux-arm32.tar] = "") do={
    :delay 1s
}
:log info "Container image downloaded."

# Restart container
/container/print
:local containerId [/container find where tag="router-satellite-alpine-linux:arm32"]
:if ([:len $containerId] = 0) do={
    :log info "No such container found with tag 'router-satellite-alpine-linux:arm32'"
    #:error "No such container found"
} else={
    /container/stop $containerId
    :delay 1s
    /container/stop $containerId
    :log info "Stopping container with tag 'router-satellite-alpine-linux:arm32'."

    # Wait until the container stops
    :while ([:len [/container find where id=$containerId and running=yes]] != 0) do={
        :delay 1s
    }

    :log info "Container stopped."
    /container/remove $containerId
    :log info "Removing container with tag 'router-satellite-alpine-linux:arm32'."

    # Wait for the container to be removed
    :while ([:len [/container find where id=$containerId]] != 0) do={
        :delay 1s
    }

    :log info "Container removed."
}


/container/add file=usb1-part1/router-satellite-alpine-linux-arm32.tar interface=veth1 root-dir=usb1-part1/alpine_root envlist=alpine_envs hostname=alpine logging=yes start-on-boot=yes
:log info "Adding new container."

# Wait for the container to be fully added by checking its status
:local newContainerId ""
:while ([:len $newContainerId] = 0) do={
    :set newContainerId [/container find where tag="router-satellite-alpine-linux:arm32" and status="stopped"]
    :delay 1s
}

:log info "New container added successfully."

# Start the new container
/container/start $newContainerId
:log info "Starting new container with tag 'router-satellite-alpine-linux:arm32'."

delay 3s
/container/print



# Wait until the container is running
#:while ([:len [/container find where id=$newContainerId and running=yes]] = 0) do={
#    :delay 1s
#}

#:log info "New container is running. Waiting for 5 seconds to ensure stability."

# Wait for 5 seconds
#:delay 5s

# Re-check the container status to confirm it's still running
#:if ([:len [/container find where id=$newContainerId and running=yes]] != 0) do={
#    :log info "Container is still running. Script completed successfully."
#} else={
#    :log error "Container is not running after 5 seconds. Script failed."
#    :error "Container failed to stay in running state"
#}

#/container/print