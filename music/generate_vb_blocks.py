#!/usr/bin/env python3

# generate_vb_blocks.py

def generate_vb_code(filename):
    with open(filename, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    vb_blocks = []
    for index, line in enumerate(lines):
        line = line.strip()
        if not line:
            continue

        # Split into artist and song
        if ' - ' in line:
            artist, song_with_ext = line.split(' - ', 1)
        else:
            artist, song_with_ext = "Unknown", line

        vb_block = f"""                        case {index}:
                                playmedia "{line}", MusicDirAlt, pMusic, "", -1, "", 1, 1

                                ShowMsg "{artist}", ""
                                ShowMsg "Now Playing:", """""
        vb_blocks.append(vb_block)

    return ''.join(vb_blocks)


if __name__ == "__main__":
    output = generate_vb_code('files.txt')
    print(output)

