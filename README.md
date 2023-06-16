# Pacstall Maintainer Tool 👨‍💼

The Pacstall Maintainer Tool is a command-line interface (CLI) written in Bash, designed to help manage the scripts (pac*) of the Pacstall package manager. This tool provides various commands to facilitate the management of packages supported by the maintainer.

## Prerequisites 📋

Before using the Pacstall Maintainer Tool, ensure that you have the following prerequisites installed on your system:

- Bash (Bourne Again SHell)

## Getting Started 🚀

To start using the Pacstall Maintainer Tool, follow the steps below:

1. Clone the repository to your local machine:

   ```shell
   git clone https://github.com/your-repo/pmt.git
   ```

2. Navigate to the project directory:

   ```shell
   cd pmt
   ```

3. Make sure the `pmt` file has executable permissions:

   ```shell
   chmod +x pmt
   ```

4. Create the necessary package script files inside the `packages` folder. Each package script should have the format `$package-name.sh` and implement the following functions:

   - `version`: This function should display the current version of the package.
   - `update`: This function should fetch the most recent version of the package and compare it with the local version, informing the result.
   - `upgrade`: This function should update the Pacstall script to the latest available version of the package.

5. Start using the Pacstall Maintainer Tool by executing the `pmt` script:

   ```shell
   ./pmt [command] [arguments]
   ```

## Commands ⚙️

The Pacstall Maintainer Tool provides the following commands:

- `list` 📜: Lists all projects supported by the maintainer.

   ```shell
   ./pmt list
   ```

- `update` 🔄: Fetches the most recent version of each package and compares it with the local version, informing the result. It can also take the package name as an argument for a specialized search.

   ```shell
   ./pmt update [package-name]
   ```

- `upgrade` ⬆️: Upgrades the Pacstall script to the latest available version of the specified package.

   ```shell
   ./pmt upgrade [package-name]
   ```

- `install` 📦: Installs the package from the local script for testing purposes.

   ```shell
   ./pmt install [package-name]
   ```

- `remove` 🗑️: Removes the specified package.

   ```shell
   ./pmt remove [package-name]
   ```

Please note that you need to replace `[command]` and `[package-name]` with the actual command and package name, respectively.

## Contributing 🤝

If you would like to contribute to the Pacstall Maintainer Tool, feel free to open issues or submit pull requests on the [GitHub repository](https://github.com/your-repo/pmt). Your contributions are greatly appreciated.

## License 📄

This project is licensed under the [MIT License](LICENSE).
