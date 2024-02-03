<template>
  <Page>
    <ActionBar title="About"/>

    <FlexboxLayout
      justifyContent="space-around"
      alignItems="center"
      flexDirection="column"
    >
      <Image src="~/images/icon-1024.png" height="256"/>
      <FlexboxLayout
        alignItems="center"
        flexDirection="column"
        class="about"
      >
        <Label text="NativeScript Timer" style="font-weight: bold;"/>
        <Label height="10"/>
        <Label
          text="A simple Android and iOS app developed with NativeScript"
          textWrap="true" width="250" textAlignment="center"
        />
      </FlexboxLayout>
    </FlexboxLayout>
  </Page>
</template>

<script lang="ts">
import Vue from "nativescript-vue";
 
export default Vue.extend({
  name: 'About',
  components: {
  },
  data: () => {
    return {
    };
  },
  methods: {
  }
});
</script>

<style scoped lang="scss">
.about {
  font-size: 16;
}
</style>
