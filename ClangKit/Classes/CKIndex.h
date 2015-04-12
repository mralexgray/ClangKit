
@interface CKIndex: NSObject

/// Internal libclang index object

@property (readonly) CXIndex cxIndex;

/// Whether to exclude declarations from the PCH file or not

@property BOOL excludeDeclarationsFromPCH;

/// Whether to display diagnostics or not

@property BOOL displayDiagnostics;

/// Returns an autoreleased index object
+ (instancetype) index;

@end
