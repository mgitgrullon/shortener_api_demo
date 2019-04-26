<template>
  <div class="url-item">
    <a v-bind:href=url.url class="block group hover:bg-blue p-2 border-b">
      <p class="font-bold text-lg mb-1 text-black group-hover:text-white">{{url.title || 'None'}}</p>
      <p class="text-grey-darker text-base group-hover:text-white">{{url.url}}</p>
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
