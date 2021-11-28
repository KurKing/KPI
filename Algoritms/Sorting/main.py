# T.printTime("Bubble", size, T.countTime(bubble_sort))
# T.printTime("Insertion", size, T.countTime(insertion_sort))
# T.printTime("Selection", size, T.countTime(selection_sort))
# T.printTime("Merge", size, T.countTime(merge_sort))
# T.printTime("Quick", size, T.countTime(quick_sort))
# T.printTime("Shell", size, T.countTime(shell_sort))
# T.printTime("Heap", size, T.countTime(heap_sort))
# T.printTime("Radix", size, T.countTime(radix_sort))
# T.printTime("Bucket", size, T.countTime(bucket_sort))
# T.printTime("Count", size, T.countTime(count_sort))

from Tester import Tester

from Sortings.bubble import bubble_sort
from Sortings.heap import heap_sort
from Sortings.insertion import insertion_sort
from Sortings.merge import merge_sort
from Sortings.quick import quick_sort
from Sortings.selection import selection_sort
from Sortings.shell import shell_sort
from Sortings.radix import radix_sort
from Sortings.bucket import bucket_sort
from Sortings.count import count_sort

T = Tester()

size = 6
# T.printTime("\nBucket", size, T.countTime(bucket_sort))
# T.printTime("Quick", size, T.countTime(quick_sort))