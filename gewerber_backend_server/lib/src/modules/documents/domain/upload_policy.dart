/// Conservative upload policy for user-provided document files.
///
/// The whitelist is intentionally narrow: it covers what a solo Gewerbe
/// owner realistically stores (receipts, invoices, logos, simple exports)
/// and nothing else. Executable formats (`.exe`, `.js`, `.html`, `.svg`, …),
/// archives beyond plain `.zip` and Office macro formats are rejected —
/// files are stored verbatim in the private storage and served back through
/// the download endpoint, so anything a browser might execute must never
/// enter the system.
///
/// Extension decides, MIME type corroborates:
/// - the file extension MUST be whitelisted (`ValidationException` otherwise);
/// - a provided `mimeType` MUST be one of the globally allowed types
///   (`ValidationException` otherwise);
/// - if both are present but disagree (e.g. `invoice.pdf` with
///   `text/plain`), the extension wins and only a warning is logged —
///   clients frequently mislabel MIME types, while the extension drives
///   storage naming and later download behaviour.
library;

/// File extensions accepted for upload (lowercase, with leading dot).
const Set<String> allowedUploadExtensions = {
  '.pdf',
  '.png',
  '.jpg',
  '.jpeg',
  '.webp',
  '.txt',
  '.csv',
  // Plain ZIP archives for bulk uploads/exports; no nested-archive or
  // self-extracting formats.
  '.zip',
};

/// MIME types accepted for upload (lowercase). Superset of the types that
/// correspond to [allowedUploadExtensions]; a value outside this set is
/// always rejected when provided by the client.
const Set<String> allowedUploadMimeTypes = {
  'application/pdf',
  'image/png',
  'image/jpeg',
  'image/webp',
  'text/plain',
  'text/csv',
  'application/zip',
  // Common alternative spellings of the two types above.
  'application/x-zip-compressed',
  'application/octet-stream',
};

/// The MIME types that legitimately match each whitelisted extension.
/// Used only for the mismatch warning — never for rejection.
const Map<String, Set<String>> expectedMimeTypesByExtension = {
  '.pdf': {'application/pdf'},
  '.png': {'image/png'},
  '.jpg': {'image/jpeg'},
  '.jpeg': {'image/jpeg'},
  '.webp': {'image/webp'},
  '.txt': {'text/plain'},
  '.csv': {'text/csv', 'text/plain'},
  '.zip': {'application/zip', 'application/x-zip-compressed'},
};
