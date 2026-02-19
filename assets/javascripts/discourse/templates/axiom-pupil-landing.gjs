import { i18n } from "discourse-i18n";

export default <template>
  <div class="container axiom-pupil-landing">
    <header class="axiom-pupil-landing__header">
      <h1>{{i18n "axiom_pupil_landing.title"}}</h1>
      <p>{{i18n "axiom_pupil_landing.subtitle"}}</p>
    </header>

    <section class="axiom-pupil-landing__options">
      <article class="axiom-pupil-landing__option">
        <h2>{{i18n "axiom_pupil_landing.team.title"}}</h2>
        <p>{{i18n "axiom_pupil_landing.team.description"}}</p>

        {{#if @model.team.url}}
          <a class="btn btn-primary btn-large" href={{@model.team.url}}>
            {{i18n "axiom_pupil_landing.team.action"}}
          </a>
          <p class="axiom-pupil-landing__destination">{{@model.team.name}}</p>
        {{else}}
          <p class="axiom-pupil-landing__unavailable">
            {{i18n "axiom_pupil_landing.unavailable"}}
          </p>
        {{/if}}
      </article>

      <article class="axiom-pupil-landing__option">
        <h2>{{i18n "axiom_pupil_landing.forum.title"}}</h2>
        <p>{{i18n "axiom_pupil_landing.forum.description"}}</p>

        {{#if @model.forum.url}}
          <a class="btn btn-primary btn-large" href={{@model.forum.url}}>
            {{i18n "axiom_pupil_landing.forum.action"}}
          </a>
          <p class="axiom-pupil-landing__destination">{{@model.forum.name}}</p>
        {{else}}
          <p class="axiom-pupil-landing__unavailable">
            {{i18n "axiom_pupil_landing.unavailable"}}
          </p>
        {{/if}}
      </article>
    </section>
  </div>
</template>
