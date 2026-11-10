# Processeur RISC-V minimal sur FPGA (Basys3)

Processeur 32 bits décrit en **VHDL** et synthétisé avec **Vivado** pour une carte **Basys3**. Il s'inspire de l'architecture **RISC-V**. Un programme de démonstration est chargé dans la ROM, et son résultat s'affiche sur les LEDs de la carte.

## Sommaire

- [Contexte](#contexte)
- [Aperçu](#aperçu)
- [Fonctionnalités](#fonctionnalités)
- [Structure du projet](#structure-du-projet)
- [Matériel](#matériel)
- [Compilation et téléversement](#compilation-et-téléversement)

## Contexte

Le projet consiste à programmer un microprocesseur sur FPGA en VHDL. Il est construit à partir de modules simples (compteur de programme, ROM, décodeur, banc de registres, multiplexeur, ALU, RAM) assemblés dans un module `top`.

## Aperçu

### Format d'une instruction

Une instruction tient sur 21 bits :

| Bits    | 20      | 19 à 15 | 14 à 10 | 9 à 5 | 4 à 0    |
|---------|---------|---------|---------|-------|----------|
| Champ   | `param` | `rd`    | `rs2`   | `rs1` | `opcode` |

Si `param` vaut 1, le champ `rs2` est utilisé comme **valeur immédiate** (0 à 31) au lieu d'un numéro de registre.

### Jeu d'instructions

| Opcode  | Mnémonique | Action                                                                 |
|---------|------------|------------------------------------------------------------------------|
| `00000` | `ADD`      | `rd = rs1 + rs2`                                                       |
| `00001` | `SUB`      | `rd = rs1 - rs2`                                                       |
| `00010` | `AND`      | `rd = rs1 & rs2`                                                       |
| `00011` | `XOR`      | `rd = rs1 ^ rs2`                                                       |
| `00100` | `LW`       | `rd = RAM[rs1 + rs2]`                                                  |
| `00101` | `SW`       | `RAM[rs2] = rs1`                                                       |
| `00110` | `JMP`      | `PC = rs2`                                                             |
| `00111` | `BEQ`      | si `rs1 == rs2`, alors `PC = rs2`                                      |

Dans ce tableau, `rs2` désigne le registre ou l'immédiat, selon `param`. Tout autre opcode est sans effet.

### Programme de démonstration

| Adresse | Instruction        | Effet                                       |
|---------|--------------------|---------------------------------------------|
| 0       | `ADD r1, r0, #7`   | `r1 = 7`                                    |
| 1       | `ADD r2, r0, #5`   | `r2 = 5`                                    |
| 2       | `BEQ r2, #5`       | `r2 == 5` : saut à l'adresse 5              |
| 3 et 4  | `ADD ...`          | ignorées par le saut                        |
| 5       | `ADD r3, r1, r2`   | `r3 = 12`                                   |
| 6       | `SUB r4, r1, r2`   | `r4 = 2`                                    |
| 7       | `AND r5, r1, r2`   | `r5 = 5`                                    |
| 8       | `XOR r6, r1, r2`   | `r6 = 2`                                    |
| 9       | `SW [#3], r3`      | `RAM[3] = 12`                               |
| 10      | `LW r7, [r0 + #3]` | `r7 = 12`                                   |
| 11      | `JMP #11`          | boucle infinie, LEDs = valeur de `r7`       |

Résultat attendu : les LEDs affichent **12**, soit `0000 0000 0000 1100` (LD2 et LD3 allumées).

## Fonctionnalités

- 8 instructions : arithmétique et logique, accès mémoire, saut et branchement conditionnel
- Valeurs immédiates sur 5 bits
- 32 registres de 32 bits, RAM de 32 mots, ROM de 32 instructions
- Affichage d'un registre sur les 16 LEDs de la carte

## Structure du projet

```text
.
├── processeur.xpr                      # Projet Vivado
└── processeur.srcs/
    ├── constrs_1/new/
    │   └── basys3.xdc                  # Contraintes : horloge et LEDs
    └── sources_1/new/
        ├── top.vhd                     # Assemblage du processeur
        ├── pack.vhd                    # Opcodes
        ├── programme_counter.vhd       # Compteur de programme
        ├── rom.vhd                     # Mémoire programme
        ├── decodeur.vhd                # Décodage des instructions
        ├── registres.vhd               # Banc de registres
        ├── multiplexer.vhd             # Choix registre / immédiat
        ├── alu.vhd                     # Unité arithmétique et logique
        └── ram.vhd                     # Mémoire de données
```

## Matériel

Carte **Basys3** (Artix-7 `xc7a35tcpg236-1`). Broches utilisées :

| Signal     | Broche             |
|------------|--------------------|
| `clk`      | W5 (horloge 100 MHz) |
| `led[0]` à `led[15]` | U16, E19, U19, V19, W18, U15, U14, V14, V13, V3, W3, U3, P3, N3, P1, L1 |

## Compilation et téléversement

1. Ouvrir `processeur.xpr` dans Vivado 2024.1 (le module `top` est le module racine).
2. Lancer **Run Synthesis**, **Run Implementation** puis **Generate Bitstream**.
3. Brancher la Basys3 en USB, puis **Open Hardware Manager**, **Open Target**, **Program Device**.
