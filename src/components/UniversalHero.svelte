<script>
  import { onMount } from "svelte";

  export let title = "";
  export let subtitle = "";
  export let ctaText = "";
  export let ctaLink = "#";
  export let layout = "center-overlay";
  
  // NEW PROP: Enable video controls?
  export let videoControls = false;

  let rootEl;       // Reference to the main section
  let videoEl;      // Reference to the video tag
  let isMuted = true;
  let isPlaying = true;

  // When the component loads in the browser...
  onMount(() => {
    if (videoControls && rootEl) {
      // Find the video element inside the slot
      videoEl = rootEl.querySelector("video");
      
      if (videoEl) {
        // Sync state with actual video settings
        isMuted = videoEl.muted;
        isPlaying = !videoEl.paused;
      }
    }
  });

  function toggleMute() {
    if (!videoEl) return;
    videoEl.muted = !videoEl.muted;
    isMuted = videoEl.muted;
  }

  function togglePlay() {
    if (!videoEl) return;
    if (videoEl.paused) {
      videoEl.play();
      isPlaying = true;
    } else {
      videoEl.pause();
      isPlaying = false;
    }
  }
</script>

<section class="hero-root" data-layout={layout} bind:this={rootEl}>
  
  {#if layout !== 'minimal'}
    <div class="hero-media">
        <slot name="media" />
    </div>
  {/if}

  <div class="hero-content">
    {#if title}
      <h1 class="hero-title">{@html title}</h1>
    {/if}
    
    {#if subtitle}
      <p class="hero-subtitle">{subtitle}</p>
    {/if}
    
    {#if ctaText}
      <div class="hero-actions">
        <a href={ctaLink} class="primary-btn">{ctaText}</a>
      </div>
    {/if}
  </div>

  {#if videoControls}
    <div class="video-controls">
      
      <button on:click={togglePlay} aria-label="Toggle Play">
        {#if isPlaying}
           <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><rect x="6" y="4" width="4" height="16"></rect><rect x="14" y="4" width="4" height="16"></rect></svg>
        {:else}
           <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M5 3l14 9-14 9V3z"/></svg>
        {/if}
      </button>

      <button on:click={toggleMute} aria-label="Toggle Sound">
        {#if isMuted}
           <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M16.5 12c0-1.77-1.02-3.29-2.5-4.03v2.21l2.45 2.45c.03-.2.05-.41.05-.63zm2.5 0c0 .94-.2 1.82-.54 2.64l1.51 1.51C20.63 14.91 21 13.5 21 12c0-4.28-2.99-7.86-7-8.77v2.06c2.89.86 5 3.54 5 6.71zM4.27 3L3 4.27 7.73 9H3v6h4l5 5v-6.73l4.25 4.25c-.67.52-1.42.93-2.25 1.18v2.06c1.38-.31 2.63-.95 3.69-1.81L19.73 21 21 19.73 4.27 3zM12 4L9.91 6.09 12 8.18V4z"/></svg>
        {:else}
           <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M3 9v6h4l5 5V4L7 9H3zm13.5 3c0-1.77-1.02-3.29-2.5-4.03v8.05c1.48-.73 2.5-2.25 2.5-4.02zM14 3.23v2.06c2.89.86 5 3.54 5 6.71s-2.11 5.85-5 6.71v2.06c4.01-.91 7-4.49 7-8.77s-2.99-7.86-7-8.77z"/></svg>
        {/if}
      </button>

    </div>
  {/if}

</section>

<style>
  /* --- BASE PHYSICS --- */
  .hero-root {
    position: relative;
    width: 100%;
    min-height: var(--hero-height, 60vh);
    background-color: var(--hero-bg-color, #eee);
    color: var(--hero-text-color, #333);
    font-family: var(--hero-font-family, sans-serif);
    overflow: hidden;
  }

  .hero-title {
    font-size: var(--hero-title-size, 3rem);
    font-weight: var(--hero-title-weight, 700);
    text-transform: var(--hero-title-case, none);
    line-height: var(--hero-line-height, 1.1);
    letter-spacing: var(--hero-letter-spacing, normal);
    margin: 0 0 1rem 0;
    word-break: break-word; /* Safety */
    overflow-wrap: break-word;
  }

  .hero-subtitle {
    font-size: var(--hero-subtitle-size, 1.25rem);
    opacity: 0.9;
    max-width: var(--hero-text-width, 60ch);
    margin-bottom: 2rem;
    /* Alignment fix for right-aligned text */
    margin-left: var(--subtitle-margin-left, 0); 
    margin-right: var(--subtitle-margin-right, 0);
  }

  .primary-btn {
    display: inline-block;
    padding: var(--btn-padding, 1rem 2rem);
    background: var(--btn-bg, black);
    color: var(--btn-text, white);
    border-radius: var(--btn-radius, 4px);
    text-decoration: none;
    font-weight: 600;
    border: var(--btn-border, none);
    transition: transform 0.2s;
  }
  .primary-btn:hover { transform: scale(1.02); }

  /* --- VIDEO CONTROLS --- */
  .video-controls {
    position: absolute;
    bottom: 2rem;
    right: 2rem;
    z-index: 10;
    display: flex;
    gap: 0.5rem;
  }

  .video-controls button {
    background: rgba(0,0,0,0.5);
    border: 1px solid rgba(255,255,255,0.3);
    color: white;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: background 0.2s;
    padding: 0;
  }
  
  .video-controls button:hover {
    background: rgba(0,0,0,0.8);
    border-color: white;
  }

  /* --- LAYOUT LOGIC --- */
  
  /* CENTER OVERLAY */
  .hero-root[data-layout="center-overlay"] {
    display: flex;
    flex-direction: column;
    align-items: var(--hero-align, center);
    justify-content: var(--hero-justify, center);
    padding: var(--hero-padding, 2rem);
    text-align: var(--hero-text-align, center);
  }
  .hero-root[data-layout="center-overlay"] .hero-media {
    position: absolute;
    inset: 0;
    z-index: 0;
    opacity: var(--hero-overlay-opacity, 0.4);
  }
  .hero-root[data-layout="center-overlay"] .hero-media :global(img),
  .hero-root[data-layout="center-overlay"] .hero-media :global(video) {
     width: 100%; height: 100%; object-fit: cover;
  }
  .hero-root[data-layout="center-overlay"] .hero-content {
    position: relative;
    z-index: 1;
    width: 100%;
    max-width: 100%;
  }

  /* SPLIT SCREEN */
  .hero-root[data-layout^="split"] {
    display: grid;
    grid-template-columns: 1fr; 
  }
  @media (min-width: 768px) {
    .hero-root[data-layout="split-right"] { grid-template-columns: 1fr 1fr; }
    .hero-root[data-layout="split-left"] { grid-template-columns: 1fr 1fr; direction: rtl; }
    .hero-root[data-layout="split-left"] .hero-content { direction: ltr; }
  }
  .hero-root[data-layout^="split"] .hero-media {
    position: relative;
    width: 100%;
    height: 100%;
    min-height: 300px;
  }
  .hero-root[data-layout^="split"] .hero-media :global(img),
  .hero-root[data-layout^="split"] .hero-media :global(video) {
    width: 100%; height: 100%; object-fit: cover;
    position: absolute; inset: 0;
  }
  .hero-root[data-layout^="split"] .hero-content {
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: var(--hero-padding, 4rem);
    align-items: flex-start;
    text-align: left;
    width: 100%;
    max-width: 100%;
  }

  /* MINIMAL */
  .hero-root[data-layout="minimal"] {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: var(--hero-padding, 4rem);
    text-align: center;
  }
</style>