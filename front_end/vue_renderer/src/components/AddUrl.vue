<template>
    <form @submit.prevent="addUrl">
      <div class="mb-6">
        <input type="text" v-model="original_url" name="original_url" placeholder="your-url.com" class="input">
      </div>
      <br/>
      <button type="submit" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green hover:bg-green-dark block w-full py-4 text-white items-center justify-center">Generate</button>
    </form>
</template>

<script>
export default {
  name: 'AddUrl',
  data () {
    return {
      original_url: ''
    }
  },
  methods: {
    addUrl () {
      const newUrl = {
        original_url: this.original_url
      }
      this.$emit('add-url', newUrl)
      this.original_url = ''
    }
  }
}
</script>

<style scoped>
</style>
