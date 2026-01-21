#!/bin/bash

# 1. Create directories
mkdir -p src/styles/themes
mkdir -p src/components

# 2. Create Startup Theme
cat <<'EOF' > src/styles/themes/startup.css
.theme-startup {
  /* Layout Physics */
  --hero-height: 80vh;
  --hero-padding: 4rem;
  --hero-align: center;
  --hero-justify: center;
  
  /* Typography Physics */
  --hero-title-size: clamp(3rem, 6vw, 5rem);
  --hero-title-weight: 800;
  --hero-title-case: none;
  --hero-font-family: 'Helvetica Neue', sans-serif;
  
  /* Color/Shape Physics */
  --hero-bg-color: #eff6ff;
  --hero-text-color: #1e3a8a;
  --btn-radius: 9999px;
  --btn-bg: #2563eb;
  --btn-text: white;
}
EOF

# 3. Create Corporate Theme
cat <<'EOF' > src/styles/themes/corporate.css
.theme-corporate {
  /* Layout Physics */
  --hero-height: 60vh;
  --hero-padding: 6rem;
  --hero-align: center;
  --hero-justify: flex-start;
  
  /* Typography Physics */
  --hero-title-size: 3.5rem;
  --hero-title-weight: 400;
  --hero-title-case: uppercase;
  --hero-font-family: 'Georgia', serif;
  
  /* Color/Shape Physics */
  --hero-bg-color: #0f172a;
  --hero-text-color: #f8fafc;
  --btn-radius: 2px;
  --btn-bg: white;
  --btn-text: #0f172a;
}
EOF

# 4. Create UniversalHero Component
cat <<'EOF' > src/components/UniversalHero.svelte
<script>
  export let title = "Default Title";
  export let subtitle = "Default subtitle goes here.";
  export let ctaText = "Get Started";
  export let layout = "default"; 
</script>

<section class="hero-shell" data-layout={layout}>
  <div class="hero-bg">
    <slot name="background" />
  </div>

  <div class="hero-content">
    <h1 class="hero-title">{title}</h1>
    <p class="hero-subtitle">{subtitle}</p>
    
    <div class="hero-actions">
      <button class="primary-btn">{ctaText}</button>
    </div>
  </div>
</section>

<style>
  .hero-shell {
    position: relative;
    width: 100%;
    min-height: var(--hero-height, 60vh);
    display: flex;
    align-items: var(--hero-align, center);
    justify-content: var(--hero-justify, center);
    padding: var(--hero-padding, 2rem);
    background-color: var(--hero-bg-color, #eee);
    color: var(--hero-text-color, #333);
    font-family: var(--hero-font-family, sans-serif);
    overflow: hidden;
  }

  .hero-bg {
    position: absolute;
    inset: 0;
    z-index: 0;
    opacity: 0.2;
  }
  
  .hero-content {
    position: relative;
    z-index: 1;
    max-width: 800px;
    width: 100%;
  }

  .hero-title {
    font-size: var(--hero-title-size, 3rem);
    font-weight: var(--hero-title-weight, 700);
    text-transform: var(--hero-title-case, none);
    line-height: 1.1;
    margin-bottom: 1rem;
  }

  .primary-btn {
    padding: 1rem 2rem;
    font-size: 1rem;
    font-weight: 600;
    border: none;
    cursor: pointer;
    background: var(--btn-bg, black);
    color: var(--btn-text, white);
    border-radius: var(--btn-radius, 4px);
    transition: transform 0.2s;
  }

  .primary-btn:hover {
    transform: scale(1.05);
  }
</style>
EOF

# 5. Create the Demo Page (index.astro)
cat <<'EOF' > src/pages/index.astro
---
import UniversalHero from '../components/UniversalHero.svelte';
import '../styles/themes/startup.css';
import '../styles/themes/corporate.css';
---

<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title>Factory Prototype</title>
        <style>
            body { margin: 0; font-family: sans-serif; }
        </style>
	</head>
	<body>

        <div class="theme-startup">
            <UniversalHero 
                title="Ship Faster." 
                subtitle="The infrastructure for modern teams."
                ctaText="Start Building"
            />
        </div>

        <div class="theme-corporate">
            <UniversalHero 
                title="Legal Excellence." 
                subtitle="Defending your rights with 30 years of experience."
                ctaText="Consultation"
            />
        </div>

	</body>
</html>
EOF

echo "Setup complete! Run 'npm run dev' now."