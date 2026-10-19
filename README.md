# CV LaTeX (Awesome-CV)

Curriculum vitae personnel basé sur le modèle [Awesome-CV](https://github.com/posquit0/Awesome-CV). Les sources principales sont dans `docs/` ; la classe `awesome-cv.cls` est à la **racine du dépôt**.

## Prévisualisation (PDF)

Compile d’abord les PDF (Docker ou `make`), puis :

| | Lien |
|---|------|
| **CV court** | [**Ouvrir `docs/cv.pdf`**](docs/cv.pdf) |
| **CV étendu (EN)** | [**Ouvrir `docs/cv-long.pdf`**](docs/cv-long.pdf) |
| **CV étendu (FR)** | [**Ouvrir `docs/cv-long-fr.pdf`**](docs/cv-long-fr.pdf) |

- Sur **GitHub** / **GitLab** : en affichant le README sur le site, un clic sur le lien ouvre le fichier ; GitHub propose un lecteur PDF intégré.
- **En local** (Cursor, VS Code, etc.) : `Ctrl`+clic ou clic selon l’outil ouvre souvent le PDF dans l’IDE ou le lecteur système.
- Les liens ne montrent rien tant que les fichiers **n’existent pas** ou **ne sont pas poussés** sur le dépôt distant (pense à committer les `.pdf` si tu veux les partager via le README).

> **Aperçu visuel (image) dans le README** : le Markdown n’affiche pas un PDF comme une image. Si tu veux une **miniature cliquable**, exporte la première page en PNG (ex. `docs/images/cv-preview-short.png`) et ajoute par exemple `[![Aperçu CV court](docs/images/cv-preview-short.png)](docs/cv.pdf)`.

## Versions PDF

| Fichier source | PDF produit | Rôle |
|----------------|-------------|------|
| `docs/cv.tex` | **`docs/cv.pdf`** | Version **courte EN** : expérience et compétences compactes. |
| `docs/cv-long.tex` | **`docs/cv-long.pdf`** | Version **étendue EN**. |
| `docs/cv-long-fr.tex` | **`docs/cv-long-fr.pdf`** | Version **étendue FR** (ton IT francophone). |

Tous pointent vers `docs/cv-root.tex`. Variante : `\def\cvvariant{short|long}` ; langue : `\def\cvlang{en|fr}` (défaut `en`).

- **Court EN** : `experience-short.tex`, `skills-short.tex`
- **Long EN** : `experience-long.tex`, `skills-long.tex`
- **Long FR** : `experience-long-fr.tex`, `skills-long-fr.tex`, `education-fr.tex`, `certificates-fr.tex`

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

# Version longue EN → docs/cv-long.pdf
docker run --rm --user "$(id -u):$(id -g)" \
  -v "$PWD":/work -w /work/docs \
  -e TEXINPUTS=/work: \
  texlive/texlive:latest \
  sh -c 'xelatex -interaction=nonstopmode -output-directory=. cv-long.tex && xelatex -interaction=nonstopmode -output-directory=. cv-long.tex'

# Version longue FR → docs/cv-long-fr.pdf
docker run --rm --user "$(id -u):$(id -g)" \
  -v "$PWD":/work -w /work/docs \
  -e TEXINPUTS=/work: \
  texlive/texlive:latest \
  sh -c 'xelatex -interaction=nonstopmode -output-directory=. cv-long-fr.tex && xelatex -interaction=nonstopmode -output-directory=. cv-long-fr.tex'
```

- **`TEXINPUTS=/work:`** : LaTeX trouve `awesome-cv.cls` à la racine du dépôt pendant que le répertoire de travail est `docs/` (où vivent `cv.tex`, `cv-root.tex` et les `\input{cv/...}`).
- Le **double passage** `xelatex` évite les références / signets incomplets.

Image utilisée : `texlive/texlive:latest` (premier tirage peut être long).

## Compilation locale

Avec TeX Live complet et outils à jour :

```bash
make cv.pdf         # docs/cv.pdf
make cv-long.pdf    # docs/cv-long.pdf (EN)
make cv-long-fr.pdf # docs/cv-long-fr.pdf (FR)
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