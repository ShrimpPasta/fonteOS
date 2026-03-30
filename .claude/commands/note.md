Create a new note in the vault.

Steps:
1. Ask the user for: note topic, type (stream/intelligence/agent), and parent spring if applicable.
2. Scan existing vault files to identify at least 3 relevant files to wikilink.
3. Generate the note with:
   - YAML frontmatter (type, spring, status, tags, updated)
   - At least 3 wikilinks ([[filename]]) in the body text, linked to real existing files
   - A ## Related section at the bottom listing backlinks
4. Write the file to the correct path based on type:
   - stream → springs/[spring]/stream/[topic].md
   - intelligence → intelligence/[topic].md
   - agent → agents/[name].md
5. Update the parent spring index to reference the new file.

Never create a note with zero wikilinks. Isolated nodes are a failure state.
