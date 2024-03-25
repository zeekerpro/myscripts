# My Script Library

Welcome to My Script Library, my personal collection of scripts developed to automate and streamline my development workflow and system management tasks. This repository is a central hub for various custom scripts I've created to make my daily operations more efficient and manageable.

## About This Repository

This repository contains scripts that tackle a range of tasks, from database version management with `pgsql` to file backups, system health checks, and more. Each script is tailored to my specific needs, offering solutions to challenges I frequently encounter in my development environment.

### Featured Scripts

- **pgsql**: A script for managing multiple PostgreSQL versions on macOS, leveraging the asdf version manager. It allows for easy switching between versions, ensuring that database testing and development can proceed with the required version specificity.

## Getting Started

To get started with these scripts, clone this repository to your local machine:

```bash
git clone https://github.com/<your-username>/my-script-library.git
```

Navigate into the repository directory:

```bash
cd my-script-library
```

Make sure to make each script executable (where `script_name.sh` is the name of the script):

```bash
chmod +x script_name.sh
```

Certainly! Here's a completion of the **Usage** section with added details on adding the script directory to your PATH for easier access.

---

## Usage

Each script in this collection is equipped with its own set of instructions and help documentation, enabling straightforward operation and customization according to your needs. You have the flexibility to run a script directly from the terminal, either by navigating to its directory or by adding the script directory to your PATH for global access.

### Running Scripts Directly

To execute a script directly within its folder, use the following command format in the terminal:

```bash
./script_name.sh [options]
```

This method is straightforward and works well when you're working within the script's directory.

### Adding Script Directory to Your PATH

For convenience and to enable execution from any location on your system, you can add the script directory to your PATH environment variable. This step requires you to modify your shell configuration file (e.g., `.bashrc`, `.zshrc`, `.bash_profile`) by appending the directory containing your scripts. Here's how to do it:

1. Open your terminal and use a text editor to open your shell configuration file. If you're using Bash, you might edit `.bashrc` or `.bash_profile`; for Zsh users, it's `.zshrc`. The command might look like this:

   ```bash
   nano ~/.bashrc
   ```

2. Add the following line to the end of the file:

   ```bash
   export PATH="$PATH:/path/to/your/script_directory"
   ```

   Replace `/path/to/your/script_directory` with the actual path where your scripts are located.

3. Save the changes and exit the text editor. For the changes to take effect, either restart your terminal or source your profile with a command like:

   ```bash
   source ~/.bashrc
   ```

   or, for Zsh:

   ```bash
   source ~/.zshrc
   ```

After completing these steps, you'll be able to execute any script from the collection by simply typing its name followed by any required or optional arguments, from anywhere in your system:

```bash
script_name.sh [options]
```

---

## Contributing

As this is a personal repository, I'm not actively seeking contributions. However, I'm open to ideas and suggestions that could improve my scripts or introduce new ones that fit my workflow. Feel free to open an issue to discuss potential enhancements.

## License

Unless stated otherwise, the scripts in this repository are made available under the MIT License. See the LICENSE file in this repository for more information.

## Acknowledgements

- Thanks to all the open source tools and libraries that make these scripts possible.
- A special thanks to the PostgreSQL community and the developers of asdf for their invaluable resources.

