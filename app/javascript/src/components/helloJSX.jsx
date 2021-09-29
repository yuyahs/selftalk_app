export default {
  name: 'HelloJSX',
  data() {
    return {
      title: 'HelloJSX',
      message: 'This is a sample page',
    }
  },
  render(h) {
    return (
      <div class="text-center">
        <h2>{ this.title }</h2>
        <p>{ this.message }</p>
      </div>
    )
  }
}