import re
import subprocess

import xkeysnail.transform
from xkeysnail.transform import K, Key

xkeysnail.transform.define_modmap({
    Key.CAPSLOCK: Key.LEFT_CTRL,
    Key.LEFT_ALT: Key.LEFT_META,
    Key.MUHENKAN: Key.ESC,
    Key.HENKAN: Key.RIGHT_ALT,
    Key.KATAKANAHIRAGANA: Key.RIGHT_META,
    Key.RIGHT_ALT: Key.RIGHT_META,
    Key.RIGHT_CTRL: Key.RIGHT_META,
    Key.RO: Key.RIGHT_SHIFT,
    Key.YEN: Key.BACKSLASH,
    #Key.LEFT: Key.LEFT_META,
    Key.ESC: Key.GRAVE,
})

xkeysnail.transform.define_conditional_modmap(re.compile('Funkin', re.IGNORECASE), {
    Key.KEY_1: Key.LEFT,
    Key.KEY_3: Key.DOWN,
    Key.SEMICOLON: Key.UP,
    Key.APOSTROPHE: Key.RIGHT,

    Key.Z: Key.LEFT,
    Key.X: Key.DOWN,
    Key.DOT: Key.UP,
    Key.SLASH: Key.RIGHT,

    Key.CAPSLOCK: Key.LEFT_CTRL,
    Key.LEFT_ALT: Key.LEFT_META,
    Key.MUHENKAN: Key.ESC,
    Key.HENKAN: Key.RIGHT_ALT,
    Key.KATAKANAHIRAGANA: Key.RIGHT_META,
    Key.RIGHT_ALT: Key.RIGHT_META,
    Key.RIGHT_CTRL: Key.RIGHT_META,
    Key.RO: Key.RIGHT_SHIFT,
    Key.YEN: Key.BACKSLASH,
    Key.ESC: Key.GRAVE,
})

xkeysnail.transform.define_keymap(re.compile('firefox|Chromium'), {
    K('C-n'): Key.DOWN,
    K('C-p'): Key.UP,
    K('C-b'): Key.LEFT,
    K('C-f'): Key.RIGHT,
    K('C-e'): Key.END,
    K('C-j'): Key.ENTER,
    K('C-h'): Key.BACKSPACE,
    K('C-w'): K('C-Backspace'),
    K('C-m'): Key.ENTER,
    K('C-o'): K('M-Left'),
    K('C-i'): K('M-Right'),
}, 'Firefox and Chromium')

xkeysnail.transform.define_keymap(re.compile('jetbrains-.+|FocusProxy'), {
    K('C-n'): Key.DOWN,
    K('C-p'): Key.UP,
    K('C-b'): Key.LEFT,
    K('C-f'): Key.RIGHT,
    K('C-j'): Key.ENTER,
    K('C-m'): Key.ENTER,
    K('C-h'): Key.BACKSPACE,
    Key.SPACE: K('Shift-Space'),
}, 'IntelliJ IDEA')

xkeysnail.transform.define_keymap(re.compile('code'), {
    K('C-n'): Key.DOWN,
    K('C-p'): Key.UP,
    K('C-b'): Key.LEFT,
    K('C-f'): Key.RIGHT,
    K('C-j'): Key.ENTER,
    K('C-m'): Key.ENTER,
    K('C-h'): Key.BACKSPACE,
}, 'VSCode')

subprocess.check_call(['xset', 'r', 'rate', '200', '50'])
subprocess.check_call(['xset', '-b'])
