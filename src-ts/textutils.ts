/** Tiny text utilities (TypeScript demo). Mirrors the Python contract. */

export function slugify(text: string): string {
  const ascii = text.normalize("NFKD").replace(/[^\x00-\x7F]/g, "");
  return ascii
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}

export function wordCount(text: string): number {
  const trimmed = text.trim();
  return trimmed === "" ? 0 : trimmed.split(/\s+/).length;
}
