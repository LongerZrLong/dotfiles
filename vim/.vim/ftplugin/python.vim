let b:ale_fixers = {'python': ['black', 'isort']}

let b:ale_python_flake8_options = '
      \ --ignore="E501"'  " ignore line length

