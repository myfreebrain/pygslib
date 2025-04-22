project('pygslib', 'c', 'cpp', 'fortran',
  version: '0.0.0.0.9',
  default_options: ['buildtype=release', 'warning_level=1'])

# Python dependency
py = import('python').find_installation('python3')
py_dep = py.dependency()

# Cython dependency
cython = find_program('cython', required: true)

# NumPy include path
numpy_inc = run_command(py, ['-c', 'import numpy; print(numpy.get_include())'], check: true).stdout().strip()
numpy_dep = declare_dependency(include_directories: numpy_inc)

# Compiler options
fortran_args = ['-Wno-error']  # Ported from extra_compile_args in setup.py
c_args = ['/W0']  # Suppress warnings for MSVC (equivalent to -Wno-error)
cpp_args = ['/W0']  # Suppress warnings for MSVC

# Cython generator for .pyx files
cython_gen = generator(cython,
  arguments: ['@INPUT@', '--output-file', '@OUTPUT@', '-3'],
  output: '@BASENAME@.c'
)

# Define Fortran extensions
gslib_kt3d = py.extension_module('gslib.__gslib__kt3d',
  sources: [
    'for_code/kt3d/kt3d.f90',
    'for_code/kt3d/gslib/setrot.f90',
    'for_code/kt3d/gslib/getindx.f90',
    'for_code/kt3d/gslib/picksupr.f90',
    'for_code/kt3d/gslib/setsupr.f90',
    'for_code/kt3d/gslib/sqdist.f90',
    'for_code/kt3d/gslib/cova3.f90',
    'for_code/kt3d/gslib/ktsol.f90',
    'for_code/kt3d/gslib/sortem.f90',
    'for_code/kt3d/gslib/srchsupr.f90'
  ],
  fortran_args: fortran_args,
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

gslib_postik = py.extension_module('gslib.__gslib__postik',
  sources: [
    'for_code/postik/postik.f90',
    'for_code/postik/gslib/beyond.f90',
    'for_code/postik/gslib/locate.f90',
    'for_code/postik/gslib/powint.f90',
    'for_code/postik/gslib/sortem.f90'
  ],
  fortran_args: fortran_args,
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

gslib_rotscale = py.extension_module('gslib.__rotscale',
  sources: ['for_code/rotscale.f90'],
  fortran_args: fortran_args,
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

gslib_block_covariance = py.extension_module('gslib.__block_covariance',
  sources: ['for_code/block_covariance.f90'],
  fortran_args: fortran_args,
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

gslib_read_gslib = py.extension_module('gslib.__read_gslib',
  sources: ['for_code/read_gslib.f90'],
  fortran_args: fortran_args,
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

gslib_addcoord = py.extension_module('gslib.__addcoord',
  sources: ['for_code/addcoord.f90'],
  fortran_args: fortran_args,
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

gslib_general = py.extension_module('gslib.__general',
  sources: ['for_code/general.f90'],
  fortran_args: fortran_args,
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

gslib_plot = py.extension_module('gslib.__plot',
  sources: ['for_code/plot.f90'],
  fortran_args: fortran_args,
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

gslib_declus = py.extension_module('gslib.__declus',
  sources: ['for_code/declus.f90'],
  fortran_args: fortran_args,
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

gslib_dist_transf = py.extension_module('gslib.__dist_transf',
  sources: ['for_code/dist_transf.f90'],
  fortran_args: fortran_args,
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

gslib_variograms = py.extension_module('gslib.__variograms',
  sources: ['for_code/variograms.f90'],
  fortran_args: fortran_args,
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

gslib_bigaus = py.extension_module('gslib.__bigaus',
  sources: ['for_code/bigaus.f90'],
  fortran_args: fortran_args,
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

gslib_bicalib = py.extension_module('gslib.__bicalib',
  sources: ['for_code/bicalib.f90'],
  fortran_args: fortran_args,
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

gslib_trans = py.extension_module('gslib.__trans',
  sources: ['for_code/trans.f90'],
  fortran_args: fortran_args,
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

gslib_draw = py.extension_module('gslib.__draw',
  sources: ['for_code/draw.f90'],
  fortran_args: fortran_args,
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

gslib_dm2csv = py.extension_module('gslib.__dm2csv',
  sources: ['for_code/dm2csv.f90'],
  fortran_args: fortran_args,
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

# Define Cython extensions
drillhole_c = cython_gen.process('cython_code/drillhole.pyx')
drillhole = py.extension_module('drillhole',
  sources: [drillhole_c],
  c_args: c_args,
  include_directories: [numpy_inc],
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

blockmodel_c = cython_gen.process('cython_code/blockmodel.pyx')
blockmodel = py.extension_module('blockmodel',
  sources: [blockmodel_c],
  c_args: c_args,
  include_directories: [numpy_inc],
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

vtktools_c = cython_gen.process('cython_code/vtktools.pyx')
vtktools = py.extension_module('vtktools',
  sources: [vtktools_c],
  c_args: c_args,
  include_directories: [numpy_inc],
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

nonlinear_c = cython_gen.process('cython_code/nonlinear.pyx')
nonlinear = py.extension_module('nonlinear',
  sources: [nonlinear_c],
  c_args: c_args,
  include_directories: [numpy_inc],
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

sandbox_c = cython_gen.process('cython_code/sandbox.pyx')
sandbox = py.extension_module('sandbox',
  sources: [sandbox_c],
  c_args: c_args,
  include_directories: [numpy_inc],
  dependencies: [py_dep, numpy_dep],
  install: true,
  subdir: 'pygslib'
)

# Pure Python modules
py.install_sources(
  ['pygslib/progress.py', 'pygslib/surpac.py'],
  subdir: 'pygslib'
)

# Package data
# Note: List all files in pygslib/data/ explicitly. Update this list if files in the data/ directory change.
data_files = files(
  'pygslib/data/data.dat',  # Replace with actual file names
  'pygslib/data/cluster.csv'       # Add more files as needed
)
py.install_sources(
  data_files,
  subdir: 'pygslib/data'
)