<template>
  <!-- <v-autocomplete
        prepend-icon='mdi-train'
        suffix='駅'
        v-model="setStation"
        :items="items"
        cache-items
        flat
        label="最寄り駅"
      /> -->
  <v-text-field
    v-model="setStation"
    prepend-icon="mdi-train"
    suffix="駅"
    label="最寄り駅"
    :rules="rules"
  />
</template>

<script>
export default {
  props: {
    station: {
      type: String,
      required: true,
    },
  },
  computed: {
    setStation: {
      get () { return this.station },
      set (newVal) { return this.$emit('update:station', newVal) },
    },
    rules () {
      return [
        v => !!v || '',
      ]
    },
    // items() {
    //   return [
    //     '渋谷',
    //     '新宿',
    //     '池袋',
    //     '東京',
    //     '秋葉原',
    //     '赤羽',
    //     '新橋',
    //     '銀座',
    //     '原宿',
    //     '上野',
    //     '品川',
    //     '立川',
    //     '大宮',
    //     '武蔵浦和',
    //     '南浦和',
    //     '札幌',
    //     'すすきの',
    //     '大通り',
    //     '手稲',
    //     '千歳'
    //   ]
    // }
  },
}
</script>
