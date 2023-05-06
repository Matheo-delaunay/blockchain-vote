<script setup lang="ts">
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap/dist/js/bootstrap.js";


const makeProposal = () => {
    const value = document.querySelector("#addedProposal").value
    emit("makeProposal", value)
}
const emit = defineEmits<{
    (e: 'makeProposal', value: string): void
}>()

</script>

<template>
    <div class="container py-2">
        <div class="row my-4">
            <div class="col-8">
                <label for="addedProposal" class="form-label">Make a proposal</label>
                <input class="form-control" type="text" id="addedProposal"/>
            </div>
            <div class="col-4 d-grid my-auto">
                <button class="btn btn-primary btn-block" id="buttonAdd" v-on:click="makeProposal">Submit proposal
                </button>
            </div>
        </div>
    </div>
</template>

<style scoped>

</style>