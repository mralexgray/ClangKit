
#import "CKIndex.h"

@implementation CKIndex @synthesize cxIndex = _cxIndex;

+ (instancetype)index { return self.new; }

- init { return self = super.init ? _cxIndex = clang_createIndex(0, 0), self : nil; }

- (void)dealloc { clang_disposeIndex(_cxIndex); }

- (void)setExcludeDeclarationsFromPCH:(BOOL)value {

  @synchronized(self) {
    if (value == _excludeDeclarationsFromPCH) return;
    clang_disposeIndex(_cxIndex);
    _excludeDeclarationsFromPCH = value;
    _cxIndex = clang_createIndex((int)_excludeDeclarationsFromPCH, (int)_displayDiagnostics);
  }
}

- (void)setDisplayDiagnostics:(BOOL)value {
  @synchronized(self) {
    if (value == self.displayDiagnostics) return;
    clang_disposeIndex(_cxIndex);

      _displayDiagnostics = value;
    _cxIndex = clang_createIndex((int)_excludeDeclarationsFromPCH, (int)_displayDiagnostics);
  }
}

@end


//- (BOOL)excludeDeclarationsFromPCH {
//  @synchronized(self) {
//    return _excludeDeclarationsFromPCH;
//  }
//}

//- (BOOL)displayDiagnostics {
//  @synchronized(self) {
//    return _displayDiagnostics;
//  }
//}

//{
//@protected
//  BOOL _excludeDeclarationsFromPCH, _displayDiagnostics;
//}
