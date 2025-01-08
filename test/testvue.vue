<template>
  <h5 class="asd" @click="test10">
    test hello
    test hello
    test hello
    test hello
    test hello
    test hello
    test hello
    test hello
    test hello
    test hello
  </h5>

    <div>h ello</div>
</template>
<script lang="ts" setup>
// definePageMeta({});


if(true){

} else if(false){

} else {
}
// asdfasdf
const test = [
    {
        age: 11,
        name: "test",
    },
    {
        name: "test",
        age: 12,
    },
]

const tes = ref(false);

const te = computed(() => {
  return "123";
});

const test9 = () => {
    if(true){
        console.log("test9");
    }
  console.log("test9");
};

const test10 = () => {
  console.log("test10");
};

const test11 = () => {
  console.log("test11");
};


// functio which adds two number
const adder = (a: number, b: number) => {
  return a + b;
};

// this multiplies
const multiplier = (a: number, b: number) => {
  return a * b;
};

onMounted(() => {
    multiplier(2, 3);
})
</script>
