# CV LaTeX (Awesome-CV)

Curriculum vitae personnel basé sur le modèle [Awesome-CV](https://github.com/posquit0/Awesome-CV). Les sources principales sont dans `docs/` ; la classe `awesome-cv.cls` est à la **racine du dépôt**.

## Prévisualisation (PDF)

Compile d’abord les PDF (Docker ou `make`), puis :

| | Lien |
|---|------|
| **CV court** | [**Ouvrir `docs/cv.pdf`**](docs/cv.pdf) |
| **CV étendu** | [**Ouvrir `docs/cv-long.pdf`**](docs/cv-long.pdf) |

- Sur **GitHub** / **GitLab** : en affichant le README sur le site, un clic sur le lien ouvre le fichier ; GitHub propose un lecteur PDF intégré.
- **En local** (Cursor, VS Code, etc.) : `Ctrl`+clic ou clic selon l’outil ouvre souvent le PDF dans l’IDE ou le lecteur système.
- Les liens ne montrent rien tant que les fichiers **n’existent pas** ou **ne sont pas poussés** sur le dépôt distant (pense à committer les `.pdf` si tu veux les partager via le README).

> **Aperçu visuel (image) dans le README** : le Markdown n’affiche pas un PDF comme une image. Si tu veux une **miniature cliquable**, exporte la première page en PNG (ex. `docs/images/cv-preview-short.png`) et ajoute par exemple `[![Aperçu CV court](docs/images/cv-preview-short.png)](docs/cv.pdf)`.

## Deux versions PDF

| Fichier source | PDF produit | Rôle |
|----------------|-------------|------|
| `docs/cv.tex` | **`docs/cv.pdf`** | Version **courte** : expérience et compétences compactes (usage courant). |
| `docs/cv-long.tex` | **`docs/cv-long.pdf`** | Version **étendue** : expérience détaillée et compétences enrichies. |

Les deux pointent vers `docs/cv-root.tex` (mise en page, en-tête, pied de page). La variante est fixée par `\def\cvvariant{short}` ou `\def\cvvariant{long}`.

- **Court** : `docs/cv/experience-short.tex`, `docs/cv/skills-short.tex`
- **Long** : `docs/cv/experience-long.tex`, `docs/cv/skills-long.tex`

Formation, certificats et autres sections sont partagés.

## Compilation avec Docker (le plus simple)

Inutile d’installer TeX Live localement : l’image fournit les paquets (dont `fontawesome6`) et les polices.

**Depuis la racine du dépôt** (là où se trouve `awesome-cv.cls`) :

```bash
# Version courte → docs/cv.pdf
docker run --rm --user "$(id -u):$(id -g)" \
  -v "$PWD":/work -w /work/docs \
  -e TEXINPUTS=/work: \
  texlive/texlive:latest \
  sh -c 'xelatex -interaction=nonstopmode -output-directory=. cv.tex && xelatex -interaction=nonstopmode -output-directory=. cv.tex'

# Version longue → docs/cv-long.pdf
docker run --rm --user "$(id -u):$(id -g)" \
  -v "$PWD":/work -w /work/docs \
  -e TEXINPUTS=/work: \
  texlive/texlive:latest \
  sh -c 'xelatex -interaction=nonstopmode -output-directory=. cv-long.tex && xelatex -interaction=nonstopmode -output-directory=. cv-long.tex'
```

- **`TEXINPUTS=/work:`** : LaTeX trouve `awesome-cv.cls` à la racine du dépôt pendant que le répertoire de travail est `docs/` (où vivent `cv.tex`, `cv-root.tex` et les `\input{cv/...}`).
- Le **double passage** `xelatex` évite les références / signets incomplets.

Image utilisée : `texlive/texlive:latest` (premier tirage peut être long).

## Compilation locale

Avec TeX Live complet et outils à jour :

```bash
make cv.pdf        # produit docs/cv.pdf
make cv-long.pdf   # produit docs/cv-long.pdf
```

Le `Makefile` appelle **LuaLaTeX** ; les `.tex` peuvent indiquer **XeLaTeX** en en-tête. En cas de différence de rendu, privilégie la même commande que le commentaire `%!TEX TS-program` du fichier principal.

## Typographie

`docs/cv/cv-font-scale.tex` (chargé par `cv-root.tex`) augmente un peu les tailles par rapport au modèle d’origine. Pour revenir au gabarit Awesome-CV par défaut, commente `\input{cv/cv-font-scale.tex}` dans `docs/cv-root.tex` (et éventuellement repasse `\documentclass` en `11pt` si tu le souhaites).

## Crédits

- [Awesome-CV](https://github.com/posquit0/Awesome-CV) — Claud D. Park (modèle d’origine, licence CC BY-SA 4.0).
- Font Awesome 6 (paquet LaTeX), polices du modèle (ex. Source Sans 3) : voir la doc du dépôt upstream.


```bash
 docker run --rm --user "$(id -u):$(id -g)" -v "$PWD":/work -w /work -e TEXINPUTS=/work: texlive/texlive:latest  make cv.pdf
```