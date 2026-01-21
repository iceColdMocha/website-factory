<script>
  export let title = "";
  export let subtitle = "";
  // Items: { title: string, text: string, icon: string }
  export let items = []; 
  export let columns = 3;
</script>

<section class="grid-section">
  <div class="header">
    {#if title}<h2>{title}</h2>{/if}
    {#if subtitle}<p>{subtitle}</p>{/if}
  </div>

  <div class="grid-container" style="--cols: {columns}">
    {#each items as item}
      <article class="card">
        <div class="card-icon">{item.icon}</div>
        <h3>{item.title}</h3>
        <p>{item.text}</p>
      </article>
    {/each}
  </div>
</section>

<style>
  /* --- SECTION WRAPPER --- */
  .grid-section {
    padding: var(--section-padding, 4rem) 2rem;
    background: var(--section-bg, #fff);
    color: var(--hero-text-color, #333); /* Inherit text color from theme */
    font-family: var(--hero-font-family, sans-serif);
  }

  .header {
    text-align: center;
    max-width: 800px;
    margin: 0 auto 4rem auto;
  }
  .header h2 {
    font-size: clamp(2rem, 4vw, 3rem);
    font-weight: var(--hero-title-weight, 700);
    text-transform: var(--hero-title-case, none);
    margin-bottom: 1rem;
  }

  /* --- THE GRID PHYSICS --- */
  .grid-container {
    display: grid;
    /* Responsive columns logic */
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    
    /* THE MAGIC: Theme controls the gap */
    gap: var(--grid-gap, 2rem);
    
    /* If corporate theme uses "gap as border", this bg color shows through */
    background-color: var(--grid-gap-color, transparent); 
    
    max-width: var(--container-width, 1400px);
    margin: 0 auto;
  }

  /* --- THE CARD PHYSICS --- */
  .card {
    background: var(--card-bg, #fff);
    padding: var(--card-padding, 2rem);
    border: var(--card-border, none);
    border-radius: var(--card-radius, 0);
    box-shadow: var(--card-shadow, none);
    
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    transition: transform 0.2s;
  }

  .card:hover {
    transform: translateY(-5px); /* Subtle interaction for all */
  }

  .card-icon {
    font-size: var(--icon-size, 2rem);
    margin-bottom: 1.5rem;
    display: block;
  }

  .card h3 {
    font-size: 1.5rem;
    font-weight: 700;
    margin: 0 0 1rem 0;
    text-transform: var(--hero-title-case, none); /* Match hero casing */
  }

  .card p {
    opacity: 0.8;
    line-height: 1.6;
    margin: 0;
  }
</style>