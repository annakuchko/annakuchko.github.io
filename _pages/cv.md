---
layout: archive
title: "CV"
permalink: /cv/
author_profile: true
redirect_from:
  - /resume
---


<div class="cv-viewer">
  <div class="cv-viewer__actions">
    <a
      class="btn btn--primary"
      href="{{ '/files/CV Anna Kuchko 1p.pdf' | relative_url }}"
      target="_blank"
      rel="noopener"
    >
      Open CV in new tab
    </a>
    <a
      class="btn btn--inverse"
      href="{{ '/files/CV Anna Kuchko 1p.pdf' | relative_url }}"
      download
    >
      Download PDF
    </a>
  </div>
  <div class="cv-viewer__frame">
    <iframe
      src="https://mozilla.github.io/pdf.js/web/viewer.html?file={{ '/files/CV Anna Kuchko 1p.pdf' | absolute_url | uri_escape }}"
      loading="lazy"
      title="Curriculum Vitae for Anna Kuchko"
    >
    </iframe>
  </div>
  <p>
    The embedded viewer is powered by Mozilla's PDF.js for consistent dark-mode rendering.
    If it does not load in your browser, use the buttons above to open or download the CV directly.
  </p>
</div>
