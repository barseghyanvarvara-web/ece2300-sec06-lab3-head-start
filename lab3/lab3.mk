#=========================================================================
# lab3
#=========================================================================

lab3_srcs = \
  DLatch_GL.v \
  DFF_GL.v \
  DFF_RTL.v \
  DFFR_GL.v \
  DFFR_RTL.v \
  DFFRE_GL.v \
  DFFRE_RTL.v \

lab3_tests = \
  DLatch_GL-test.v \
  DFF_GL-test.v \
  DFF_RTL-test.v \
  DFFR_GL-test.v \
  DFFR_RTL-test.v \
  DFFRE_GL-test.v \
  DFFRE_RTL-test.v \

$(eval $(call check_part,lab3))
