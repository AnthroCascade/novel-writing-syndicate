# Novel Writing Syndicate

This is an editing and drafting system for fiction. It coordinates a group of AI collaborators — each with a specific job — to help produce and refine novel-length work. It is being developed with respect to a speculative fiction novel.

The system is part of [Mobsta](https://github.com/AnthroCascade/mobsta-prototype), an architecture for collaborative AI work. If that sounds unfamiliar, you're in the right place — the specs below are the thing itself.

## How it works

A scene or chapter moves through evaluation, drafting, and polishing. At each phase, one or more **fortes** do the work. A forte is a specialised role — it knows what to look for, what to suppress, and when it's done.

Fortes draw on **talents**: shared skill domains like scene craft, dialogue craft, or voice analysis. A talent is the method; a forte is the role that applies it.

The author controls which phase fires and when. The AI collaborators evaluate and draft; the author decides.

## Fortes

Each forte has its own spec in [`fortes/`](fortes/). Here's what they do:

| Forte | Job |
|-------|-----|
| [prose-scribe](fortes/prose-scribe/forte.md) | Drafts scene prose in the author's voice |
| [voice-guardian](fortes/voice-guardian/forte.md) | Protects voice in existing prose and dialogue |
| [slop-detector](fortes/slop-detector/forte.md) | Flags AI tells — confident vagueness, ornamental abstraction, the smooth and generic |
| [scene-architect](fortes/scene-architect/forte.md) | Scenes build, never catalogue |
| [continuity-keeper](fortes/continuity-keeper/forte.md) | The manuscript remembers what it said |
| [character-warden](fortes/character-warden/forte.md) | Characters are consistent, distinct, and growing |
| [dialogue-tuner](fortes/dialogue-tuner/forte.md) | Dialogue sounds like the speaker, not the author |
| [pacing-reader](fortes/pacing-reader/forte.md) | Tension and release alternate |
| [world-auditor](fortes/world-auditor/forte.md) | The world follows its own rules |

## Talents

Shared skill domains in [`talents/`](talents/):

| Talent | Domain |
|--------|--------|
| [voice-craft](talents/voice-craft/talent.md) | Recognising and preserving the author's voice |
| [editorial](talents/editorial/talent.md) | Refining prose: structure, rhythm, compression |
| [slop-detection](talents/slop-detection/talent.md) | Detecting AI-generated text via costly cognition |
| [critical-stance](talents/critical-stance/talent.md) | Evaluative disposition: honesty over agreeableness |
| [narrative-structure](talents/narrative-structure/talent.md) | How novels build across scenes, chapters, and parts |
| [scene-craft](talents/scene-craft/talent.md) | What makes a scene work as a unit of fiction |
| [character-craft](talents/character-craft/talent.md) | How characters exist in fiction |
| [dialogue-craft](talents/dialogue-craft/talent.md) | How dialogue works: rhythm, subtext, economy |
| [world-building](talents/world-building/talent.md) | Internal consistency of fictional worlds |
| [scrivener-nav](talents/scrivener-nav/talent.md) | Navigating Scrivener 3 project bundles |
| [kb-extraction](talents/kb-extraction/talent.md) | Persistent knowledge base: extraction, merge, artefacts |

## The governing principle

All fortes suppress AI's default fiction voice as much as they pursue their goal. The system guards against six named failure modes: premature resolution, information bleed, voice flattening, helpful synopsis (telling rather than showing), arc amnesia, and forte contradiction. The full table with defences and recovery actions is in [syndicate.md](syndicate.md).

## Knowledge base

Three fortes (continuity-keeper, character-warden, world-auditor) maintain persistent artefacts that survive between sessions — character profiles, timeline, continuity facts, and world rules. The manuscript's memory lives in these files, not in the AI's context window.

## Full specification

The complete syndicate spec — phases, coordination, failure modes, collaboration contract — is in [syndicate.md](syndicate.md).
