<template>
  <v-row justify="center">
    <v-dialog
      v-model="dialog"
      :width="dialogWidth"
    >
      <template #activator="{ on, attrs }">
        <v-btn
          color="subColor"
          class="search-btn"
          height="60"
          v-bind="attrs"
          rounded
          v-on="on"
        >
          カテゴリー検索
        </v-btn>
      </template>
      <MoleculesModal>
        <template #modal-title>
          <AtomsFormTitle :title="title" />
        </template>
        <template #modal-content>
          <v-form
            v-model="setIsValid"
            class="d-flex align-center"
          >
            <v-row>
              <v-col
                cols="12"
                sm="6"
              >
                <AtomsFormCategory
                  :category-ids.sync="setCategoryIds"
                  :category-items="categoryItems"
                />
              </v-col>
              <v-col
                cols="6"
                sm="3"
                align-self="center"
                class="d-flex justify-center"
              >
                <AtomsFormButtonSearch
                  :loading="loading"
                  :category-ids="categoryIds"
                  @search="search"
                />
              </v-col>
              <v-col
                cols="6"
                sm="3"
                align-self="center"
                class="d-flex justify-center"
              >
                <AtomsFormButtonSearchReset @reset="reset" />
              </v-col>
            </v-row>
          </v-form>
        </template>
      </MoleculesModal>
    </v-dialog>
  </v-row>
</template>

<script>
export default {
  props: {
    loading: {
      type: Boolean,
      required: true,
      default: false,
    },
    categoryIds: {
      type: Array,
      required: true,
    },
    categoryItems: {
      type: Array,
      required: true,
    },
    title: {
      type: String,
      required: true,
    },
    isValid: {
      type: Boolean,
      required: true,
      default: false,
    },
  },
  data () {
    return {
      dialog: false,
    }
  },
  computed: {
    setCategoryIds: {
      get () { return this.categoryIds },
      set (newVal) { return this.$emit('update:category-ids', newVal) },
    },
    setIsValid: {
      get () { return this.isValid },
      set (newVal) { return this.$emit('update:is-valid', newVal) },
    },
    dialogWidth () {
      switch (this.$vuetify.breakpoint.name) {
        case 'xs': return '90%'
        case 'sm': return '60%'
        case 'md': return '45%'
        case 'lg': return '30%'
      }
      return '25%'
    },
  },
  methods: {
    search () {
      this.$emit('search')
    },
    reset () {
      this.$emit('reset')
    },
  },
}
</script>

<style lang="sass" scoped>
  .search-btn
    color: #fff
    font-size: 20px
</style>
