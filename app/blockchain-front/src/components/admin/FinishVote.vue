<script setup lang="ts">
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap/dist/js/bootstrap.js";

const emit = defineEmits<{
    (e: 'endVoting'): void
}>()

</script>

<template>
    <div class="container py-2">
        <div class="row justify-content-center">
            <button class="btn btn-primary" v-on:click="emit('endVoting')">End voting</button>
        </div>
    </div>
</template>

<style scoped>

</style>