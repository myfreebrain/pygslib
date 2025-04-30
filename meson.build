project('pygslib', 'c', 'cpp', 'fortran', 'cython',
  version: '0.0.0.7.1.1',
  meson_version : '>= 1.2.0',
  default_options: ['cpp_std=c++11', 'buildtype=release', 'warning_level=1','python.allow_limited_api=false'])
  
python = import('python').find_installation('python3',pure: false)

#py = import('python').find_installation('python3',pure: false)
py_dep = python.dependency()
#numpy_dep = dependency('numpy', required : true)
cython = find_program('cython', required: true)

incdir_f2py = run_command(python,['-c', 'import os; os.chdir(".."); import numpy.f2py; print(numpy.f2py.get_include())'],check : true).stdout().strip()
fortranobject_c = incdir_f2py / 'fortranobject.c'

# NumPy include path
numpy_inc = run_command(python, ['-c', 'import numpy; print(numpy.get_include())'], check: true).stdout().strip()
numpy_dep = declare_dependency(include_directories: numpy_inc)
f2py_dep = declare_dependency(include_directories: [numpy_inc, incdir_f2py])

# Compiler options 
fortran_args = [] #['-Wno-error']  # Ported from extra_compile_args in setup.py
c_args = ['/W0']  # Suppress warnings for MSVC (equivalent to -Wno-error)
cpp_args = ['/W0']  # Suppress warnings for MSVC

# Cython generator for .pyx files
cython_gen = generator(cython,
  arguments: ['@INPUT@', '--output-file', '@OUTPUT@', '-3'],
  output: '@BASENAME@.c'
)

pygslib_sources = []

# Fortran modules
fortran_modules = [
  ['__gslib__kt3d', ['for_code/kt3d/kt3d.f90',
                                   'for_code/kt3d/gslib/setrot.f90',
                                   'for_code/kt3d/gslib/getindx.f90',
                                   'for_code/kt3d/gslib/picksupr.f90',
                                   'for_code/kt3d/gslib/setsupr.f90',
                                   'for_code/kt3d/gslib/sqdist.f90',
                                   'for_code/kt3d/gslib/cova3.f90',
                                   'for_code/kt3d/gslib/ktsol.f90',
                                   'for_code/kt3d/gslib/sortem.f90',
                                   'for_code/kt3d/gslib/srchsupr.f90',fortranobject_c], [ 'only:', 'pykt3d', 'set_unest',  ':']],

  ['__gslib__postik', ['for_code/postik/postik.f90',
                                     'for_code/postik/gslib/beyond.f90',
                                     'for_code/postik/gslib/locate.f90',
                                     'for_code/postik/gslib/powint.f90',
                                     'for_code/postik/gslib/sortem.f90',fortranobject_c],[ 'only:', 'postik', 'set_unest', 'get_unest',  ':']],

  ['__rotscale', ['for_code/rotscale.f90',fortranobject_c],[]],
  ['__block_covariance', ['for_code/block_covariance.f90',fortranobject_c],[]],
  ['__read_gslib', ['for_code/read_gslib.f90',fortranobject_c],[]],
  ['__addcoord', ['for_code/addcoord.f90',fortranobject_c],[]],
  ['__general', ['for_code/general.f90',fortranobject_c],[]],
  ['__plot', ['for_code/plot.f90',fortranobject_c],[]],
  ['__declus', ['for_code/declus.f90',fortranobject_c],[]],
  ['__dist_transf', ['for_code/dist_transf.f90',fortranobject_c],[ 'only:', 'backtr', 'anatbl','nscore', 'ns_ttable', ':']],
  ['__variograms', ['for_code/variograms.f90',fortranobject_c],[]],
  ['__bigaus', ['for_code/bigaus.f90',fortranobject_c],[]],
  ['__bicalib', ['for_code/bicalib.f90',fortranobject_c],[]],
  ['__trans', ['for_code/trans.f90',fortranobject_c],[]],
  ['__draw', ['for_code/draw.f90',fortranobject_c],[]],
  ['__dm2csv', ['for_code/dm2csv.f90',fortranobject_c],[]],
]

foreach mod : fortran_modules
  mod_name = mod[0]
  mod_sources = mod[1]
  mod_options = mod[2]  
  pygslib_sources += python.extension_module(mod_name,
    sources : mod_sources,
    dependencies : [py_dep, f2py_dep],
    install : true,
    subdir: 'pygslib/gslib',
    #f2py_options: mod_options，
    fortran_args : ['-O3'])
endforeach

# Cython modules
cython_modules = [
  ['drillhole', 'cython_code/drillhole.pyx'],
  ['blockmodel', 'cython_code/blockmodel.pyx'],
  ['vtktools', 'cython_code/vtktools.pyx'],
  ['nonlinear', 'cython_code/nonlinear.pyx'],
  ['sandbox', 'cython_code/sandbox.pyx'],
  ['progress', 'pygslib/progress.py'],
  ['surpac', 'pygslib/surpac.py'],
]

#    command : [cython, '-3', '--cplus', '-o', '@OUTPUT@', '@INPUT@'],
foreach cy_mod : cython_modules
  cy_mod_name = cy_mod[0]
  cy_mod_source = cy_mod[1]

  cython_generated_c = custom_target(
    cy_mod_name + '_cython',
    input : cy_mod_source,
    output : '@BASENAME@.c',
    command : [cython, '-3', '-o', '@OUTPUT@', '@INPUT@'],
    depend_files : [cy_mod_source]
  )

  pygslib_sources += python.extension_module(cy_mod_name,
    sources : cython_generated_c,
    include_directories: [numpy_inc],	
    dependencies : [py_dep, numpy_dep],
    install : true,
    subdir: 'pygslib',
    cpp_args : ['-O3'])
endforeach

# Pure Python files (no compilation needed)

#install_subdir('pygslib', install_dir : 'pygslib', strip_directory : true, exclude_directories : ['__pycache__'])
install_subdir('pygslib', install_dir : python.get_install_dir() / 'pygslib', strip_directory : true, exclude_directories : ['__pycache__'])

# Data files
#install_data('README.md')
