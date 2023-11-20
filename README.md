# Alma Script Library

Welcome to the Alma Script Library. This collection of scripts and shortcuts is designed to streamline your workflow with Kubernetes (k9s). This document provides instructions for setting up and using the tools provided.

## Installation Instructions

To get started with the Alma Script Library, follow these steps:

1. **Run the Installation Script**  
   Execute the `alma-install` script located within the `scripts` directory. During the installation process, you will be prompted to provide several pieces of information:

    - **Infra Repo Absolute Path**: Enter the absolute path to your infra repository.  
      Example: `/Users/tomertwig/Alma/infra`
    - **GitHub Token**: Enter your GitHub personal access token.
    - **GitHub Username**: Enter your GitHub username.
    - **GitHub Email**: Enter your email associated with GitHub.

2. **Update Shell Environment**  
   After the installation script completes, you need to update your shell environment to recognize the new aliases. Run the following command in your terminal:

    ```sh
    source ~/.zshrc
    ```

3. **Using the Helper Script**  
   To view available shortcuts, execute the `alma-help` command. This will display a list of available scripts along with their descriptions.

## An example of available Scripts and Shortcuts

Below is a table of the scripts you can use along with a brief description of their function:

| Script         | Description                          |
|----------------|--------------------------------------|
| `installing`   | Install infra helm in a local env    |
| `upgrade`      | Upgrade infra helm in a local env    |
| `cleanup`      | Cleanup infra helm in a local env    |
| `pods`         | Display all running pods             |
| `deploy`       | Show all running deployments         |
| `trace-logs`   | Access logs for trace-processor      |
| `ddgw-logs`    | Access logs for Datadog gateway      |
| `topic-logs`   | Access logs for topic-processor      |
| `trace-agg-logs` | Access logs for trace-aggregator   |
| `query-logs`   | Access logs for query-processor      |
| `otlpgw-logs`  | Access logs for OTLP gateway         |

These scripts are accessible from anywhere in the terminal, allowing for a more efficient workflow when managing Kubernetes resources.

The Alma Script Library is a valuable toolset for enhancing productivity with k9s. Be sure to source your `.zshrc` file after the installation to apply changes. For assistance or to view the list of commands, `alma-help` is your go-to command.


## Uninstallation Instructions

If you wish to uninstall the Alma Script Library and revert your environment to its initial state, you can use the `alma-uninstall` script. Follow these steps to uninstall:

1. **Run the Uninstallation Script**  
   Execute the `alma-uninstall` command in your terminal. This script will remove all changes made by the Alma Script Library to your environment.

    ```sh
    alma-uninstall
    ```

2. **Update Shell Environment**  
   After running the uninstallation script, refresh your shell environment by sourcing your `.zshrc` file once again:

    ```sh
    source ~/.zshrc
    ```

After completing these steps, the Alma Script Library will be completely removed from your system, and any changes it made to your shell environment will be undone.

## Support

Should you encounter any issues during the uninstallation process, or require further assistance, please feel free to reach out to our support team.

We hope you found the Alma Script Library useful, and we appreciate any feedback regarding your experience.
