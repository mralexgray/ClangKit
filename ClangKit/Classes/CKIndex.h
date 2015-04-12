
@interface CKIndex: NSObject

/// Internal libclang index object

@property (readonly) CXIndex cxIndex;

/// Whether to exclude declarations from the PCH file or not

@property (nonatomic) BOOL excludeDeclarationsFromPCH, displayDiagnostics;

/// Whether to display diagnostics or not


/// Returns an autoreleased index object
+ (instancetype) index;

@end
