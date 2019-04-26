<template>
  <div>
    <div v-bind:key="url.id" v-for="url in urls">
      <UrlItem v-bind:url="url" />
    </div>
  </div>
</template>

<script>
import UrlItem from './UrlItem'

export default {
  name: 'Urls',
  components: {
    UrlItem
  },
  props: ['urls']
}
</script>

<style scoped>

</style>
