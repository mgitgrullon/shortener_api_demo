<template>
  <div id="app">
    <div class="max-w-sm m-auto my-8">
      <div class="border p-10 border-grey-light shadow rounded">
        <AddUrl v-on:add-url="addUrl"/>
        <div class="flex justify-center">
          <span class="text-2xl font-sans opacity-25 py-4">{{ shortUrl }}</span>
        </div>
      </div>
    </div>
    <div class="font-sans flex items-center justify-center w-full py-8">
      <div class="overflow-hidden bg-white rounded max-w-lg w-full shadow-lg leading-normal">
        <h2 class="font-bold text-xl mb-2 p-2">Top 100 Board</h2>
        <Urls v-bind:urls="top" />
      </div>
    </div>
  </div>
</template>

<script>

import Urls from '../components/Urls'
import AddUrl from '../components/AddUrl'
import axios from 'axios'

export default {
  name: 'Home',
  components: {
    Urls,
    AddUrl
  },
  data () {
    return {
      top: [],
      shortUrl: ''
    }
  },
  methods: {
    addUrl (newUrl) {
      const { original_url } = newUrl

      axios.post(`${process.env.ROOT_API}/short_it`, {
        original_url
      })
        .then(res => (this.shortUrl = res.data.short_url))
        .catch(err => console.log(err))
    }
  },
  created () {
    axios.get(`${process.env.ROOT_API}/top`)
      .then(res => (this.top = res.data))
      .catch(err => console.log(err))
  }
}

</script>

<style>

</style>
