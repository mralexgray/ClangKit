
#import "CKIndex.h"

@implementation CKIndex {
@protected
  BOOL _excludeDeclarationsFromPCH, _displayDiagnostics;
}

@synthesize cxIndex = _cxIndex;

+ (instancetype)index {
  return self.new;
}

- (instancetype)init {
  return self = super.init ? _cxIndex = clang_createIndex(0, 0), self : nil;
}

- (void)dealloc {
  clang_disposeIndex(_cxIndex);
}

- (BOOL)excludeDeclarationsFromPCH {
  @synchronized(self) {
    return _excludeDeclarationsFromPCH;
  }
}

- (BOOL)displayDiagnostics {
  @synchronized(self) {
    return _displayDiagnostics;
  }
}

- (void)setExcludeDeclarationsFromPCH:(BOOL)value {
  @synchronized(self) {
    if (value != _excludeDeclarationsFromPCH) {
      clang_disposeIndex(_cxIndex);

      _cxIndex = clang_createIndex((int)_excludeDeclarationsFromPCH, (int)_displayDiagnostics);
    }
  }
}

- (void)setDisplayDiagnostics:(BOOL)value {
  @synchronized(self) {
    if (value != _displayDiagnostics) {
      clang_disposeIndex(_cxIndex);

      _cxIndex = clang_createIndex((int)_excludeDeclarationsFromPCH, (int)_displayDiagnostics);
    }
  }
}

@end
