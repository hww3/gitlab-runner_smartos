#  gitlab-runner

### What is this ?

A container with a Runner for Gitlab Runner

### Features

### Build-time variables

before creating an instance, you should have a dns cname set up that points to the value you
provide for server_name below. Not only does this direct traffic to your instance, it's also
needed by let's encrypt so that it can verify that you have control over the hostname you're
attempting to secure. triton's container name service allows you to predict the hostname of 
the instance before you create it, so setting up the cname is easy.

example:  

  the uuid of my joyent account is abc
  my instance name is gitlab-runner
  my instance is in the us-east-1 datacenter

therefore, the hostname to use in my cname entry would be:

  gitlab-runner.inst.abc.us-east-1.triton.zone

so, my cname would look like this:

  server_name IN CNAME gitlab-runner.inst.abc.us-east-1.triton.zone

even if i recreate the server instance, as long as i call it the same name, the address will
always point to the ip address of the current instance(s).

now that we've covered that prerequiste, here's how you create the image using hashicorp packer:

packer build  -var-file=local_vars.json gitlab-runner.packer 

you should copy the local_vars.json.template file to local_vars.json and fill in your joyent account
information. to create an instance from the image you just created, install the triton tool and run it like this:

TODO: log to syslog and logrotate.

triton inst create --name gitlab-runner -m server_name=gitlab-runner gitlab-runner g4-highcpu-128M
# update glue record
ssh root@instance_address
#triton inst enable-firewall gitlab-runner

### Ports

- **22** for ssh access

### Additional notes
