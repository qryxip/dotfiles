/**
 * @param command {String|String[]}
 * @param stroke {String}
 * @returns {void}
 */
const nmap = (command, stroke) => {
    vimfx.set("mode.normal." + command, stroke);
};


nmap("scroll_half_page_up", "<c-u>");

nmap("history_back", "<c-o>");
nmap("history_forward", "<c-i>");

nmap("tab_new_after_current", "t");
nmap("tab_new", "T");
nmap("tab_restore", "u");

if (false) {
  nmap("scroll_half_page_down", "<delete>");
  nmap("scroll_page_down", "<arrowright>");
  nmap("scroll_page_up", "<arrowleft>");
  nmap("tab_select_next", "<arrowdown>");
  nmap("tab_select_previous", "<arrowup>");
} else {
  nmap("scroll_half_page_down", "<c-d>");
  nmap("scroll_page_down", "<c-f>");
  nmap("scroll_page_up", "<c-b>");
  nmap("tab_select_next", "<c-n>");
  nmap("tab_select_previous", "<c-p>");
}
