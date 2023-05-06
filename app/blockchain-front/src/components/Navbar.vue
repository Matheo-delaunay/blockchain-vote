<template>
    <nav class="navbar navbar-expand-lg navbar-light bg-light py-3">
        <span>{{ props.userAddressvar }}</span>
    </nav>
</template>
<script setup lang="ts">
  const props = defineProps<{userAddressvar: any}>()
</script>
<style scoped>

</style>