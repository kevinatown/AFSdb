# AFSdb README

## Requirements
Development will be done in a linux box, I have my ENV set up [here](https://github.com/kevinatown/workspaceBuilder).

You will need to have [VirtualBox](https://www.virtualbox.org/wiki/Downloads), [Vagrant](https://www.vagrantup.com/downloads.html), and a text editor or IDE -- I use [sublime text](https://www.sublimetext.com/), but it's up to you.

### Set Up Steps
**Only do this once**

First download and install virtual box and vagrant. Clone the Workspace builder:

```bash
git clone git@github.com:kevinatown/workspaceBuilder.git
```

Change the name of the workspace dir. Then enter the workspaceBuilder dir and set up the vagrantbox.

```bash
mv workspaceBuilder workspace
cd workspace
vagrant up
```

Now clone the the AFSdb repo.

```bash
git clone git@github.com:kevinatown/AFSdb.git
```

That's it your workspace is built.

## Running the App locally

From the workspace dir, make sure Vagrant is running.

```bash
vagrant up
```

Enter the vagrant box and the AFSdb dir.

```bash
vagrant ssh
cd workspace/AFSdb
```

Install Ruby Gems and set up the db:
**NOTE: This doesnt have to happen everytime, but if you are getting errors it might be nice to try this as a first troubleshooting step.**

```bash
bundle install
rake db:migrate:reset db:seed
```

Updating the DB after schema changes:
```bash
rake db:migrate
```

Updating GEMS
```bash
bundle install
```

Run the app:

```bash
rails s -b 0.0.0.0
```

Now point your your browser towards `0.0.0.0:3000`. **USE Chrome**

## Stopping the VagrantBox

Exit the box:

```bash
exit
```

Stop the machine:

```bash
vagrant halt
```

## GIT Workflow
**This is exteremly important to follow. Work will not be added unless this is followed. Follow these steps everytime you are doing new work!**

So you should do you development off of the dev branch. Always pull the dev branch before creating your branch.

```bash
git checkout dev
git pull
```

Create your branch:

```bash
git checkout -b <your_branch_name>
```

Do your development work! Once done add and commit your files:

```bash
git add -A
git commit -m 'some message explaining this commit'
```

Push your branch:
```bash
git push -u origin <your_branch_name>
```

Create a PR on github, [follow these instructions](https://help.github.com/articles/creating-a-pull-request/). You should create this PR from your branch to the `dev` branch. Once the PR is created let Kevin know through slack and I'll look it over.

