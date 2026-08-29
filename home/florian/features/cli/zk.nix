{
    programs.zk = {
        enable = true;
        exportNotebookDir = true;
        settings = {
            notebook = {
                dir = "~/Notes";
            };

            note = {
                language = "en";
            };
        };
    };

    home.persistence."/persist".directories = [
        "Notes"
    ];
}
