#!/usr/bin/python3
import getpass
import os
import platform
import shutil
import subprocess
import sys
import urllib.request
from argparse import ArgumentParser
from pathlib import Path
from tempfile import TemporaryDirectory
from typing import Optional, List


def main() -> None:
    parser = ArgumentParser()
    parser.add_argument('sections', nargs='+', help='Run only the sections')
    sections: List[str] = parser.parse_args().sections

    if getpass.getuser() == 'root':
        raise Exception('Do not run this script as root.')

    def matches(section: str) -> bool:
        return not sections or section in sections

    if matches('common'):
        common()
    if matches('linux') and platform.system() == 'Linux':
        linux()
    if matches('archlinux') and Path('/', 'etc', 'arch-release').exists():
        archlinux()
    if matches('nix') and Path('/', 'etc', 'arch-release').exists():
        nix()
    if matches('xkeysnail') and Path('/', 'etc', 'arch-release').exists():
        xkeysnail()
    if matches('python'):
        python()
    if matches('node'):
        node()
    if matches('rust'):
        rust()
    if matches('ocaml'):
        ocaml()


def common() -> None:
    home = Path.home()
    base = Path(__file__).resolve().parent
    system = platform.system()

    eprint_colored('[common] Creating symlinks...', bold=True)

    def args(dir_paths: List[str],
             filename: str) -> (Path, Path, str):
        src = base.joinpath('common', 'ln', 'homedir', *dir_paths, filename)
        dst = home.joinpath(*dir_paths, filename)
        section = 'common'
        return src, dst, section

    symlink(*args([], '.gitconfig'))
    symlink(*args([], '.gvimrc'))
    symlink(*args([], '.ideavimrc'))
    symlink(*args([], '.latexmkrc'))
    symlink(*args([], '.profile'))
    symlink(*args([], '.tern-config'))
    symlink(*args([], '.tigrc'))
    symlink(*args([], '.tmux.conf'))
    symlink(*args([], '.vimrc'))
    symlink(*args([], '.zprofile'))
    symlink(*args([], '.zshrc'))
    symlink(*args(['.config'], 'nvim'))
    symlink(*args(['.config', 'alacritty'], 'alacritty.yml'))
    symlink(*args(['.config', 'cmus'], 'rc'))
    symlink(*args(['.config', 'fish'], 'config.fish'))
    symlink(*args(['.config', 'ranger'], 'rc.conf'))
    symlink(*args(['.config', 'ranger', 'colorschemes'], 'mytheme.py'))
    symlink(*args(['.emacs.d'], 'init.el'))
    symlink(*args(['.emacs.d'], 'el'))
    symlink(*args(['.emacs.d'], 'snippets'))
    symlink(*args(['.emacs.d', 'straight'], 'versions'))
    symlink(*args(['.vim'], 'snippets'))

    def args(dir_paths: List[str],
             filename: str) -> (Path, Path, str):
        src = base.joinpath('unix', 'ln', 'homedir', *dir_paths, filename)
        dst = home.joinpath(*dir_paths, filename)
        section = 'common'
        return src, dst, section

    symlink(*args(['.config'], 'nix'))
    symlink(*args(['.config'], 'starship.toml'))

    def args(src_dir_paths: List[str],
             dst_dir_paths: List[str],
             filename: str) -> (Path, Path, str):
        src = base.joinpath('common', 'ln', 'homedir', *src_dir_paths, filename)
        dst = home.joinpath(*dst_dir_paths, filename)
        section = 'common'
        return src, dst, section

    symlink(*args(['config', 'tridactyl'], ['.config', 'tridactyl'],
                  'tridactylrc'))

    if system == 'Windows':
        raise NotImplementedError()
    elif system == 'Darwin':
        def args(filename: str) -> (Path, Path, str):
            src = base.joinpath('common', 'ln', 'homedir', '.config', 'Code - OSS',
                                'User', filename)
            dst = home.joinpath('Library', 'Application Support', 'Code',
                                'User', filename)
            section = 'common'
            return src, dst, section
    elif system == 'Linux':
        def args(filename: str) -> (Path, Path, str):
            src = base.joinpath('common', 'ln', 'homedir', '.config', 'Code - OSS',
                                'User', filename)
            dst = home.joinpath('.config', 'Code - OSS', 'User', filename)
            section = 'common'
            return src, dst, section

    symlink(*args('keybindings.json'))
    symlink(*args('settings.json'))

    git_clone('https://github.com/qryxip/scripts',
              home.joinpath('scripts'),
              'common')
    git_clone('https://github.com/Shougo/dein.vim',
              home.joinpath('.vim', 'dein.vim'),
              'common')

    if zsh := shutil.which('zsh'):
        if home.joinpath('.zplug').exists():
            eprint_colored(f'[common] zplug already installed', bold=True)
        else:
            installer = subprocess.run([
                'curl', '-sL', '--proto-redir', '-all,https',
                'https://raw.githubusercontent.com/zplug/installer/master/'
                'installer.zsh'],
                stdout=subprocess.PIPE, check=True,
            ).stdout.decode()
            subprocess.run([zsh, '-c', installer], check=True)

    if (fisher_fish := home.joinpath(
            '.config', 'fish', 'functions', 'fisher.fish')).exists():
        eprint_colored(f'[common] {fisher_fish} already exists', bold=True)
    else:
        eprint_colored(f'[common] Installing fisherman...', bold=True)
        subprocess.run(['curl', 'https://git.io/fisher', '-Lo', fisher_fish,
                        '--create-dirs'], check=True)


def linux() -> None:
    home = Path.home()
    base = Path(__file__).resolve().parent

    eprint_colored(f'[linux] Creating symlinks...', bold=True)

    def args(dir_paths: List[str],
             filename: str) -> (Path, Path, str):
        src = base.joinpath('linux', 'ln', 'homedir', *dir_paths, filename)
        dst = home.joinpath(*dir_paths, filename)
        section = 'linux'
        return src, dst, section

    symlink(*args([], 'xkb.sh'))
    symlink(*args([], '.rtorrent.rc'))
    symlink(*args([], '.xprofile'))
    symlink(*args([], '.Xresources'))
    symlink(*args([], '.xkb'))
    symlink(*args(['.config'], 'bspwm'))
    symlink(*args(['.config'], 'compton'))
    symlink(*args(['.config'], 'dolphinrc'))
    symlink(*args(['.config'], 'dunst'))
    symlink(*args(['.config'], 'libskk'))
    symlink(*args(['.config'], 'polybar'))
    symlink(*args(['.config'], 'rofi'))
    symlink(*args(['.config'], 'sxhkd'))
    symlink(*args(['.config'], 'yabar'))
    symlink(*args(['.config', 'fcitx'], 'config'))
    symlink(*args(['.config', 'fcitx'], 'conf'))
    symlink(*args(['.config', 'fcitx', 'skk'], 'dictionary_list'))
    symlink(*args(['.config', 'fcitx', 'skk'], 'rule'))
    symlink(*args(['.config', 'qpdfview'], 'shortcuts.conf'))
    # symlink(*args(['.config', 'systemd', 'user'], 'xkeysnail.service'))

    applications = base.joinpath('linux', 'ln', 'homedir', '.local', 'share',
                                 'applications')

    def args(filename: str) -> (Path, Path, str):
        src = applications.joinpath(filename)
        dst = home.joinpath('.local', 'share', 'applications', filename)
        section = 'linux'
        return src, dst, section

    for name in sorted(os.listdir(applications)):
        symlink(*args(name))

    eprint_colored(f'[linux] Copying files...', bold=True)

    def args(dir_paths: List[str], filename: str) -> (Path, Path, str):
        src = base.joinpath('linux', 'cp', 'etc', *dir_paths, filename)
        dst = Path('/').joinpath('etc', *dir_paths, filename)
        section = 'linux'
        return src, dst, section

    copy(*args(['sysctl.d'], '60-my.conf'))
    copy(*args(['systemd', 'swap.conf.d'], 'my.conf'))
    copy(*args(['X11', 'xorg.conf.d'], '30-touchpad.conf'))
    copy(*args(['X11', 'xorg.conf.d'], '50-mouse.conf'))


def archlinux() -> None:
    import pwd

    home = Path.home()
    base = Path(__file__).resolve().parent

    # # https://qiita.com/miy4/items/dd0e2aec388138f803c5
    # try:
    #     pwd.getpwnam('xkeysnail')
    #     eprint_colored(f'[archlinux] `xkeysnail` already exists', bold=True)
    # except KeyError:
    #     subprocess.run(['sudo', 'groupadd', 'uinput'], check=False)
    #     subprocess.run(
    #         ['sudo', 'useradd', '-G', 'input,uinput', '-s', '/sbin/nologin',
    #          'xkeysnail'], check=True)
    #     eprint_colored(f'[archlinux] Added `xkeysnail` and `uinput`',
    #                    bold=True)

    eprint_colored('[archlinux] Copying files...', bold=True)

    def args(dir_paths: List[str], filename: str) -> (Path, Path, str):
        src = base.joinpath('archlinux', 'cp', *dir_paths, filename)
        dst = Path('/', *dir_paths, filename)
        section = 'archlinux'
        return src, dst, section

    copy(*args(['usr', 'local', 'share', 'kbd', 'keymaps'], 'personal.map'))
    copy(*args(['etc'], 'locale.conf'))
    copy(*args(['etc'], 'vconsole.conf'))
    copy(*args(['etc', 'udev', 'rules.d'], '40-udev-xkeysnail.rules'))
    copy(*args(['etc', 'modules-load.d'], 'uinput.conf'))
    copy(*args(['etc', 'sudoers.d'], '10-installer'))
    copy(*args(['etc', 'sysctl.d'], '60-my.conf'))

    eprint_colored('[archlinux] Installing packages...', bold=True)

    subprocess.run(['sudo', 'pacman', '-Sy'], check=True)

    def install_packages(path: Path, query: List[str], install: List[str],
                         on_empty: str,
                         ) -> None:
        installed = subprocess.run(query, stdout=subprocess.PIPE,
                                   check=True).stdout.decode()
        with open(str(path)) as file:
            packages = file.read()
        packages = set(packages.splitlines())
        packages.difference_update(installed.splitlines())
        if packages:
            subprocess.run([*install, *packages], check=True)
        else:
            eprint_colored(on_empty, bold=True)

    install_packages(
        base.joinpath('archlinux', 'native.txt'),
        ['pacman', '-Qnq'],
        # ['sudo', 'pacman', '-Su', '--needed', '--noconfirm'],
        ['sudo', 'pacman', '-Su', '--needed'],
        '[archlinux] No native packages to install',
    )

    # if Path('/usr/bin/yay').exists():
    #     eprint_colored('[archlinux] `yay` is already installed', bold=True)
    # else:
    #     eprint_colored('[archlinux] Installing `yay`...', bold=True)
    #     with TemporaryDirectory(prefix='yay-installation-') as tempdir:
    #         wd = Path(tempdir).joinpath('yay')
    #         subprocess.run(
    #             ['git', 'clone', 'https://aur.archlinux.org/yay.git', wd],
    #             check=True,
    #         )
    #         subprocess.run(['makepkg', '-si'], cwd=wd, check=True)

    install_packages(
        base.joinpath('archlinux', 'foreign.txt'),
        ['pacman', '-Qmq'],
        # ['yay', '-S', '--noconfirm'],
        ['paru', '-S'],
        '[archlinux] No AUR packages to install',
    )

    eprint_colored('[archlinux] Disabling Baloo...', bold=True)

    subprocess.run(['balooctl', 'suspend'], check=True)
    subprocess.run(['balooctl', 'disable'], check=True)

    eprint_colored('[archlinux] Sealing `~/.dropbox-dist`...', bold=True)

    dropbox_dist = home.joinpath('.dropbox-dist')
    if subprocess.run(['test', '-d', dropbox_dist]).returncode == 0:
        subprocess.run(['rm', '-rf', dropbox_dist], check=True)
    dropbox_dist.mkdir()
    dropbox_dist.chmod(0o000)

    eprint_colored('[archlinux] Enabling systemd units...', bold=True)

    for service in ['bluetooth', 'ntpd']:
        subprocess.run(['sudo', 'systemctl', 'enable', '--now', service],
                       check=True)
    # subprocess.run(['sudo', 'systemctl', 'enable', 'lightdm'], check=True)


def nix() -> None:
    def set_kernel_unprivileged_userns_clone(value: str) -> None:
        subprocess.run(
            ['sudo', 'sysctl', f'kernel.unprivileged_userns_clone={value}'],
            check=True,
        )

    if Path('/nix').is_dir():
        eprint_colored('[nix] `nix` is already installed')
        return

    eprint_colored('[archlinux] Installing `nix`...', bold=True)

    installer = retrieve('https://nixos.org/nix/install', 'nix')
    subprocess.run(['sh', '-c', installer], check=True)

    eprint_colored('[nix] Installing nix packages...')

    with open('/proc/sys/kernel/unprivileged_userns_clone') as file:
        kernel_unprivileged_userns_clone = file.read()

    try:
        set_kernel_unprivileged_userns_clone('1')
        subprocess.run(
            ['bash', '-c',
             'source ~/.nix-profile/etc/profile.d/nix.sh && '
             'nix-env -iA cachix -f https://cachix.org/api/v1/install && '
             'cachix use all-hies && '
             'nix-env -iA selection --arg selector '
             '"p: { inherit (p) ghc865; } " -f '
             'https://github.com/infinisil/all-hies/tarball/master'],
            check=True,
        )
    finally:
        set_kernel_unprivileged_userns_clone(kernel_unprivileged_userns_clone)


def xkeysnail() -> None:
    base = Path(__file__).resolve().parent

    if Path('/opt/xkeysnail').is_dir():
        eprint_colored('[xkeysnail] xkeysnail is already installed', bold=True)
    else:
        eprint_colored('[xkeysnail] Installing xkeysnail...', bold=True)

        subprocess.run(
            ['sudo', '/usr/bin/python3', '-m', 'venv', '/opt/xkeysnail'],
            check=True,
        )
        subprocess.run(
            ['sudo', '/opt/xkeysnail/bin/pip3', 'install', '-U', 'pip'],
            check=True,
        )
        subprocess.run(
            ['sudo', '/opt/xkeysnail/bin/pip3', 'install', 'xkeysnail'],
            check=True,
        )
        subprocess.run(
            ['sudo', 'cp', Path(base, 'linux/opt/xkeysnail/config.py'),
             '/opt/xkeysnail/'],
            check=True,
        )


def python() -> None:
    version = platform.python_version()
    home = Path.home()

    target = Path(home, '.pyenv/versions', version)
    if target.is_dir():
        eprint_colored(f'[python] Found {target}', bold=True)
    else:
        eprint_colored(f'[python] Installing {repr(version)}...', bold=True)
        subprocess.run(['pyenv', 'install', version])
        subprocess.run(['pyenv', 'global', version])

    ranger_existed = Path(home, 'tools', 'python', version, 'ranger').is_dir()

    eprint_colored(f'[python] Installing tools for {repr(version)}...',
                   bold=True)

    for filename, spec in [('aws', 'aws'),
                           ('http', 'httpie'),
                           ('oj', 'online-judge-tools'),
                           ('pipenv', 'pipenv'),
                           ('ptpython', 'ptpython'),
                           ('pygmentize', 'tw2.pygmentize'),
                           ('ranger', 'ranger-fm'),
                           ('remarshal', 'remarshal')]:
        dst = Path(home, 'tools', 'python', version, filename)
        if dst.is_dir():
            eprint_colored(f'[python] Found {dst}', bold=True)
        else:
            eprint_colored(f'[python] Installing {spec} in {dst}...',
                           bold=True)
            subprocess.run(
                [Path(home, '.pyenv', 'versions', version, 'bin', 'python3'),
                 '-m', 'venv', dst],
                check=True
            )
            subprocess.run(
                [Path(dst, 'bin', 'pip3'), 'install', '-U', 'pip'], check=True,
            )
            subprocess.run(
                [Path(dst, 'bin', 'pip3'), 'install', spec], check=True,
            )

    if not ranger_existed:
        subprocess.run(
            [Path(home, 'tools', 'python', version, 'ranger', 'bin', 'ranger'),
             '--copy-config=all'],
            check=True,
        )


def node() -> None:
    if shutil.which('volta'):
        eprint_colored('[node] volta is already installed', bold=True)
        return
    with TemporaryDirectory(prefix='dotfiles-setup-node') as tempdir:
        path = f'{tempdir}/volta-install'
        subprocess.run(['curl', 'https://get.volta.sh', '-o', path],
                       check=True)
        subprocess.run([path], check=True)


def rust() -> None:
    if shutil.which('rustup'):
        eprint_colored('[rust] Rustup is already installed', bold=True)
        return

    home = Path.home()

    eprint_colored('[rust] Installing Rustup...', bold=True)

    rustup_init = retrieve('https://sh.rustup.rs', 'rust')
    with TemporaryDirectory(prefix='rustup-init') as path:
        path = Path(path, 'rustup-init')
        with open(path, mode='w') as file:
            file.write(rustup_init)
        subprocess.run(
            ['sh', path, '-vy', '--no-modify-path', '-c', 'rls',
             'rust-analysis', 'rust-src'],
            check=True,
        )

    eprint_colored('[rust] Installing tools...', bold=True)

    def rustup(args: List[str], cwd: Optional[Path] = None) -> None:
        subprocess.run([Path(home, '.cargo', 'bin', 'rustup'), *args],
                       cwd=cwd, check=True)

    rustup(['install', '1.15.1', '1.42.0', 'nightly'])

    rustup(['run', 'stable', 'cargo', 'install',
            'bandwhich',
            'cargo-asm',
            'cargo-audit',
            'cargo-bloat',
            'cargo-clone',
            'cargo-count',
            'cargo-crev',
            'cargo-deny',
            'cargo-deps',
            'cargo-edit',
            'cargo-feature',
            'cargo-generate',
            'cargo-license',
            'cargo-make',
            'cargo-outdated',
            'cargo-profiler',
            'cargo-script',
            'cargo-tree',
            'cargo-update',
            'cross',
            'diesel_cli',
            'du-dust',
            'exa',
            'fselect',
            'lsd',
            'mdbook',
            'onefetch',
            'starship',
            'tokei'])

    eprint_colored('[rust] Installing rust-analyzer...', bold=True)

    dst = Path(home, 'src', 'github.com', 'rust-analyzer', 'rust-analyzer')
    git_clone('https://github.com/rust-analyzer/rust-analyzer', dst, 'rust')
    rustup(['run', 'stable', 'cargo', 'xtask', 'install', '--server'], cwd=dst)


def ocaml() -> None:
    # TODO: opam init --comp ocaml-system.4.10.0
    # TODO: eval $(opam env)
    # TODO: opam repository add satysfi-external https://github.com/gfngfn/satysfi-external-repo.git
    # TODO: opam repository add satyrographos https://github.com/na4zagin3/satyrographos-repo.git
    # TODO: opam update
    raise NotImplementedError()


def eprint_colored(text: str,
                   bold: bool = False,
                   fg: Optional[int] = None) -> None:
    escape = '\x1b'
    color = sys.stderr.isatty() and os.environ.get('TERM') != 'dumb'

    print(
        f'{f"{escape}[1m" if color and bold else ""}'
        f'{f"{escape}[3{fg}m" if color and fg is not None else ""}'
        f'{text}'
        f'{f"{escape}[m" if color else ""}',
        file=sys.stderr, flush=True,
    )


def readlink(path: Path) -> Path:
    path = str(path)  # for PyCharm
    return Path(os.readlink(path))


def symlink(src: Path, dst: Path, section: str) -> None:
    if not src.exists():
        raise Exception(f'{src} does not exist')

    if not src.is_absolute():
        raise Exception(f'Non absolute path: {src}')

    if not dst.is_absolute():
        raise Exception(f'Non absolute path: {dst}')

    if dst.exists() and readlink(dst) != src:
        dst.unlink()
        dst.symlink_to(src)
        eprint_colored(f'[{section}] Updated {src} -> {dst}', bold=True)
    elif not dst.exists():
        dst.parent.mkdir(parents=True, exist_ok=True)
        dst.symlink_to(src, target_is_directory=True)
        eprint_colored(f'[{section}] Created {src} -> {dst}', bold=True)


def copy(src: Path, dst: Path, section: str) -> None:
    if not src.is_absolute():
        raise Exception(f'Non absolute path: {src}')

    if not dst.is_absolute():
        raise Exception(f'Non absolute path: {dst}')

    if subprocess.run(['sudo', 'test', '-f', dst], check=False,
                      ).returncode != 0:
        subprocess.run(['sudo', 'mkdir', '-p', dst.parent], check=True)
        subprocess.run(['sudo', 'cp', src, dst], check=True)
        eprint_colored(f'[{section}] Copied {src} to {dst}', bold=True)


def retrieve(url: str, section: str) -> str:
    eprint_colored(f'[{section}] Retrieving {url}...', bold=True)
    with urllib.request.urlopen(url, timeout=30) as res:
        return res.read().decode()


def git_clone(repo: str, dst: Path, section: str) -> None:
    if dst.exists():
        eprint_colored(f'[{section}] {dst} already exists', bold=True)
    else:
        eprint_colored(f'[{section}] Cloning {repo}...', bold=True)
        subprocess.run(['git', 'clone', repo, dst])


if __name__ == '__main__':
    main()
