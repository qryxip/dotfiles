const nmap = (command, stroke) => {
    vimfx.set("mode.normal." + command, stroke);
};

nmap("scroll_half_page_down", "<c-d>");
nmap("scroll_half_page_up", "<c-u>");
nmap("scroll_page_down", "<arrowright>");
nmap("scroll_page_up", "<arrowleft>");

nmap("tab_select_next", "<arrowdown>");
nmap("tab_select_previous", "<arrowup>");

nmap("history_back", "<c-o>");
nmap("history_forward", "<c-i>");

nmap("tab_new_after_current", "t");
nmap("tab_new", "T");
nmap("tab_restore", "u");


