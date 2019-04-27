<template>
  <div class="url-item">
    <a v-bind:href=url.sanitize_url class="block group hover:bg-blue p-2 border-b">
      <p class="text-lg font-sans text-lg mb-1 text-black group-hover:text-white">{{url.title || 'None'}}</p>
      <p class="text-grey-darker text-base group-hover:text-white">{{url.sanitize_url}}</p>
      <div class="flex justify-end">
         <span class="font-sans group-hover:text-white inline-block bg-grey-lighter rounded-full px-3 py-1 text-sm font-semibold text-grey-darker">{{url.counter}}</span>
      </div>
    </a>
  </div>
</template>

<script>
export default {
  name: 'UrlItem',
  props: ['url']
}
</script>

<style scoped>
  a {
      text-decoration: none;
  }
</style>
